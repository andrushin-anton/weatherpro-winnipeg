require 'test_helper'

class InstallerScheduleControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get installer_schedule_show_url
    assert_response :success
  end

  test "should get update" do
    get installer_schedule_update_url
    assert_response :success
  end

end
