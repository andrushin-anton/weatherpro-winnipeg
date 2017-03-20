require 'test_helper'

class AdministratorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get administrator_index_url
    assert_response :success
  end

  test "should get show" do
    get administrator_show_url
    assert_response :success
  end

  test "should get new" do
    get administrator_new_url
    assert_response :success
  end

  test "should get edit" do
    get administrator_edit_url
    assert_response :success
  end

  test "should get create" do
    get administrator_create_url
    assert_response :success
  end

  test "should get update" do
    get administrator_update_url
    assert_response :success
  end

  test "should get destroy" do
    get administrator_destroy_url
    assert_response :success
  end

end
