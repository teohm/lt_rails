require 'test_helper'

class ModelEqualityTest < ActiveSupport::TestCase

  test "New record does not equal to another new record." do
    new_record = Comment.new
    another_new = Comment.new

    assert new_record == new_record
    assert another_new == another_new
    assert new_record != another_new
  end

  test "2 records with same #id equal to each others." do
    c1 = Comment.create
    c2 = Comment.find(c1.id)

    assert c1 == c2
    assert c2 == c1
  end

  test "When applied in Array" do
    c1 = Comment.create
    c2 = Comment.find(c1.id)

    assert [c1].include? c2
    assert [c2].include? c1
    assert [c1, c2] == [c1, c2]
  end

end
