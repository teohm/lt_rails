class Comment < ActiveRecord::Base
  belongs_to :author, :class_name => "User", :counter_cache => true

  attr_accessible :content
end
