require 'test_helper'

class FragmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fragments_index_url
    assert_response :success
  end

end
