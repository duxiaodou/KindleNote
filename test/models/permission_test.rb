require 'test_helper'

class PermissionTest < ActiveSupport::TestCase
  test "should not save Permission without name、title" do
    permission = Permission.new
    assert_not permission.save
  end

  test "should save Permission with name、title、action" do
    permission = Permission.new(name: 'user-show', title: '查看用户')
    assert permission.save
  end
end
