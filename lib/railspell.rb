module RailsSpell
  class RailsDictionary < ActiveRecord::Base

    # Usage:
    # RailsDictionary.create :name => "MyOwnDictionary:::en:::150"
    
    has_many :rails_dictionary_words
    def make_default
    end

    # Using ':::' as template
    # format 'name:::language:::number_of_word'
    def dict_name
      self.name.gsub(":::").first
    end 

    def language
      self.name.gsub(":::").second
    end 

    def number_of_words
      self.name.gsub(":::").third
    end 

    def backup
      if File.exists?(dict_file)
        File.open("#{dict_file}.bkp","w") do |dest|
          File.open(dict_file) do |src|
            dest.write src 
          end 
        end 
      end 
    end 

    def create_dict
      header = "personal_ws-1.1 #{language} #{number_of_words}"
      File.open(dict_file,"w") do |new_dict|
        new_dict.puts header
        words = self.rails_dictionary_words.collect{|e| e.word}.compact.uniq 
        words.each do |word|
          new_dict.puts word 
        end 
      end
    end 

    def dict_file
      ".aspell.#{language}.pws"
    end

    def load
      backup 
      create_dict
    end 

    def unload 
      File.rename "#{dict_file}.bkp" , dict_file
    end 

    def add_word(word)
      dictionary_word = self.rails_dictionary_words.find_by_word(word)
      if dictionary_word.blank?
        self.rails_dictionary_words.create :word => word 
      end
      dictionary_word
    end

    def remove_word(word)
      dictionary_word = self.rails_dictionary_words.find_by_word(word)
      if dictionary_word
        dictionary_word.destroy
      end
      dictionary_word
    end

  end 

  class RailsDictionaryWord
    belongs_to :rails_dictionary
  end
end
