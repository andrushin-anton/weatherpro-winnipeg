json.extract! appointment, :id, :status, :is_new_customer, :schedule_time, :comments, :seller_id, :customer_id, :address, :city, :province, :postal_code, :windows_num, :doors_num, :how_soon, :quotes_num, :hear_about_us, :homeoweners_at_home, :supply_install, :financing, :installer_id, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
