require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    user = User.new
    assert !user.valid? # Assert that user.errors is not empty
    assert user.errors[:firstname].any?
    assert user.errors[:surname].any?
    assert user.errors[:grad_year].any?
    assert user.errors[:email].any?
  end
end
