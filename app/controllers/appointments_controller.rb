class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :set_data, only: [:show, :edit, :new, :create, :update]

  # GET /appointments
  # GET /appointments.json
  def index
    if params[:date]
      today = Date.parse(params[:date])
    else
      today = Date.today # Today's date
    end

    @prev_url = appointments_path + '/date/' + (today - 1.week).to_s
    @next_url = appointments_path + '/date/' + (today + 1.week).to_s
    
    # all current week days
    @days_from_this_week = (today.at_beginning_of_week..today.at_end_of_week).map
    # start and end dates for cursors
    start_time = Time.parse(today.at_beginning_of_week.to_s)
    end_time = Time.parse(today.at_end_of_week.to_s)
    # get appointments
    @appointments = Appointment.search(current_user, params[:search], start_time, end_time)
    # get sellers and installers for admins
    if current_user.role == 'admin'
      @sellers = User.where(role: 'seller').all
      @installers = User.where(role: 'installer').all
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
    authorize! :show, @appointment
  end

  # GET /appointments/new
  def new
    authorize! :new, Appointment

    schedule_time = Time.at(params[:unixtime].to_i).utc
    date = schedule_time.strftime("%Y-%m-%d")
    
    @appointment = Appointment.new
    # Process times
    case schedule_time.strftime("%H").to_i 
      when  9
        schedule_time = date + ' 09:00:00'
        end_time = date + ' 09:59:59'
      when 10..11
        schedule_time = date + ' 10:00:00'
        end_time = date + ' 11:59:59'
      when 12..13
        schedule_time = date + ' 12:00:00'
        end_time = date + ' 13:59:59'
      when 14..15
        schedule_time = date + ' 14:00:00'
        end_time = date + ' 15:59:59'   
      when 16..17
        schedule_time = date + ' 16:00:00'
        end_time = date + ' 17:59:59'
      when 18..19
        schedule_time = date + ' 18:00:00'
        end_time = date + ' 19:59:59'
      when 20..21
        schedule_time = date + ' 20:00:00'
        end_time = date + ' 21:00:00'
      else
        @appointment.errors.add(:base, 'Undefined time')
    end

    @appointment.schedule_time = schedule_time
    @appointment.end_time = end_time
  end

  # GET /appointments/1/edit
  def edit
    authorize! :edit, @appointment    
  end

  # POST /appointments
  # POST /appointments.json
  def create
    authorize! :create, Appointment

    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to appointments_path, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    authorize! :update, @appointment

    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to appointments_path, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    authorize! :destroy, @appointment

    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def set_data
      @customers = Customer.where(:status => 'ACTIVE').all()
      @sellers = User.where(:status => 'ACTIVE', :role => 'seller').all()
      @installers = User.where(:status => 'ACTIVE', :role => 'installer').all()
    end
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:new_customer_first_name, :new_customer_last_name, :new_customer_phone, :new_customer_email, :status, :is_new_customer, :schedule_time, :end_time, :comments, :seller_id, :customer_id, :address, :city, :province, :postal_code, :windows_num, :doors_num, :how_soon, :quotes_num, :hear_about_us, :homeoweners_at_home, :supply_install, :financing, :installer_id)
    end
end
