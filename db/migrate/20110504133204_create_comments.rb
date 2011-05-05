class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :content
      t.string :content_type

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
