class RailsDictionary < ActiveRecord::Base


  # Usage:
  # -----
  # RailsDictionary.create :name => "MyOwnDictionary" , [:language => "en" , :number_of_words => 5]
  #
  # RailsDictionary.activate("MyOwnDictionary") 
  # RSpell.check "vertizon" # => false
  #
  # RailsDictionary.add_words ["MyRulesMyWorld","Unpossible","Babystander","vertizon"] 
  # 
  # RSpell.check "vertizon" # => true
  #
  # RailsDictionary.remove_word "Unpossible"
  # RailsDictionary.add_word "Thou'"
  #
  # RailsDictionary.deactivate("MyOwnDictionary") 

  has_many :rails_dictionary_words
  scope :active , where(is_active: true)

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

  def self.activate(name)
    active_object = self.active
    if active_object
      return " Already activated #{active_object.name}. \n Please deactivate by RailsDictionary#deactivate(#{active_object.name})"
    end

    rdict = self.find_by_name name 
    unless rdict
      raise "Unknown Dictionary: #{name} \n  Please create #{name} in RailsDictionary before using it"
    end 
    rdict.backup 
    rdict.create_dict
    rdict.update_attribute "is_active",true
  end 

  def self.deactivate(name) 
    rdict = self.find_by_name name 
    unless rdict
      raise "Unknown Dictionary: #{name} \n  Please create #{name} in RailsDictionary before using it"
    end 
    rdict.update_attribute "is_active",false
    File.rename "#{rdict.dict_file}.bkp" , rdict.dict_file
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

  def add_words(words)
    words.each do |word|
      add_word(word)
    end 
  end

  def remove_words(words)
    words.each do |word|
      remove_word(word)
    end
  end

end 


