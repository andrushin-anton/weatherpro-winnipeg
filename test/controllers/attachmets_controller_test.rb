require 'test_helper'

class AttachmetsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get attachmets_new_url
    assert_response :success
  end

end
