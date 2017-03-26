require 'test_helper'

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @appointment = appointments(:one)
  end

  test "should get index" do
    get appointments_url
    assert_response :success
  end

  test "should get new" do
    get new_appointment_url
    assert_response :success
  end

  test "should create appointment" do
    assert_difference('Appointment.count') do
      post appointments_url, params: { appointment: { address: @appointment.address, city: @appointment.city, comments: @appointment.comments, customer_id: @appointment.customer_id, doors_num: @appointment.doors_num, financing: @appointment.financing, hear_about_us: @appointment.hear_about_us, homeoweners_at_home: @appointment.homeoweners_at_home, how_soon: @appointment.how_soon, installer_id: @appointment.installer_id, is_new_customer: @appointment.is_new_customer, postal_code: @appointment.postal_code, province: @appointment.province, quotes_num: @appointment.quotes_num, schedule_time: @appointment.schedule_time, seller_id: @appointment.seller_id, status: @appointment.status, supply_install: @appointment.supply_install, windows_num: @appointment.windows_num } }
    end

    assert_redirected_to appointment_url(Appointment.last)
  end

  test "should show appointment" do
    get appointment_url(@appointment)
    assert_response :success
  end

  test "should get edit" do
    get edit_appointment_url(@appointment)
    assert_response :success
  end

  test "should update appointment" do
    patch appointment_url(@appointment), params: { appointment: { address: @appointment.address, city: @appointment.city, comments: @appointment.comments, customer_id: @appointment.customer_id, doors_num: @appointment.doors_num, financing: @appointment.financing, hear_about_us: @appointment.hear_about_us, homeoweners_at_home: @appointment.homeoweners_at_home, how_soon: @appointment.how_soon, installer_id: @appointment.installer_id, is_new_customer: @appointment.is_new_customer, postal_code: @appointment.postal_code, province: @appointment.province, quotes_num: @appointment.quotes_num, schedule_time: @appointment.schedule_time, seller_id: @appointment.seller_id, status: @appointment.status, supply_install: @appointment.supply_install, windows_num: @appointment.windows_num } }
    assert_redirected_to appointment_url(@appointment)
  end

  test "should destroy appointment" do
    assert_difference('Appointment.count', -1) do
      delete appointment_url(@appointment)
    end

    assert_redirected_to appointments_url
  end
end
