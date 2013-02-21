class CreateRailsDictionaryWords < ActiveRecord::Migration
  def self.up
    create_table :rails_dictionary_words do |t|
      t.string  :word
      t.integer :rails_dictionary_id 
      t.timestamps
    end
  end

  def self.down
    drop_table :rails_dictionary_words
  end
end
