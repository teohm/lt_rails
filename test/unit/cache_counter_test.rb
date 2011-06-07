require 'test_helper'

class CacheCounterTest < ActiveSupport::TestCase

  def setup
    @user = User.create(:email => "user@mail.com")
  end

  test "can set counter default value in migration schema." do
    assert_equal 0, @user.comments.size
    assert_equal 0, @user.comments_count
  end

  test "should auto-increment counter when new record created." do
    comment = Comment.new(:content => "cool")
    comment.author = @user
    comment.save

    @user.reload # reload required

    assert_equal 1, @user.comments.size
    assert_equal 1, @user.comments_count
    assert_equal @user.updated_at, @user.created_at, "updated_at should not change."
  end

  test "should auto-increment counter when new record created via collection." do
    comment = @user.comments.create(:content => "cool")

    @user.reload # reload required

    assert_equal 1, @user.comments.size
    assert_equal 1, @user.comments_count
    assert_equal @user.updated_at, @user.created_at, "updated_at should not change."
  end

  test "should auto-decrement counter when record destroyed." do
    comment = @user.comments.create(:content => "cool")
    @user.reload

    comment.destroy

    @user.reload

    assert_equal 0, @user.comments.size
    assert_equal 0, @user.comments_count
    assert_equal @user.updated_at, @user.created_at, "updated_at should not change."
  end

  test "should auto-decrement counter when record destroyed via collection." do
    comment = @user.comments.create(:content => "cool")
    @user.reload

    @user.comments.destroy_all

    @user.reload

    assert_equal 0, @user.comments.size
    assert_equal 0, @user.comments_count
    assert_equal @user.updated_at, @user.created_at, "updated_at should not change."
  end

  test "counter auto-increment/decrement callback not called when Model.delete_all" do
    comment = @user.comments.create(:content => "cool")
    @user.reload

    Comment.delete_all # auto-increment/decrement callacbk not called

    @user.reload

    assert_equal 1, @user.comments_count
  end

end