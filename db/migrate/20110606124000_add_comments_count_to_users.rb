class AddCommentsCountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :comments_count, :integer, :default => 0

    User.reset_column_information
    User.all.each do |user|
      user.update_attribute :comments_count, user.comments.length
    end
  end

  def self.down
    remove_column :users, :comments_count
  end
end
