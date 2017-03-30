require 'test_helper'

class SellerScheduleControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get seller_schedule_show_url
    assert_response :success
  end

  test "should get update" do
    get seller_schedule_update_url
    assert_response :success
  end

end
