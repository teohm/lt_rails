require 'test_helper'

class MassAssignmentTest < ActiveSupport::TestCase

  test "Ensure certain attrs not accessible via mass-assignment" do
    assert (not Comment.accessible_attributes.include? :content_type)
    assert (not Comment.accessible_attributes.include? :author_id)
  end

  test "Mass-assignment via #new" do
    c = Comment.new(:content_type => "spam", :author_id => 99)
    assert_nil c.content_type
    assert_nil c.author_id
  end

  test "Mass-assignment via #create" do
    c = Comment.create(:content_type => "spam", :author_id => 99)
    assert_nil c.content_type
    assert_nil c.author_id
  end

  test "Mass-assignment via #attributes=" do
    c = Comment.new
    c.attributes = {:content_type => "spam", :author_id => 99}
    assert_nil c.content_type
    assert_nil c.author_id
  end
end
