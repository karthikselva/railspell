class CreateRailsDictionaries < ActiveRecord::Migration
  def self.up
    create_table :rails_dictionaries do |t|
      t.string  :name
      t.timestamps
    end
  end

  def self.down
    drop_table :rails_dictionaries
  end
end
