class CreateRailsDictionaries < ActiveRecord::Migration
  def self.up
    create_table :rails_dictionaries do |t|
      t.string  :name
      t.string :language , :default => "en"
      t.integer :number_of_words , :default => 0
      t.boolean :is_active , :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :rails_dictionaries
  end
end
