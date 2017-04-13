class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    authorize! :index, Customer

    @customers = Customer.search(params[:search], params[:page])
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    authorize! :show, @customer
  end

  # GET /customers/new
  def new
    authorize! :new, Customer

    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
    authorize! :edit, @customer
  end

  # POST /customers
  # POST /customers.json
  def create
    authorize! :create, Customer

    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to customers_url, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    authorize! :update, @customer

    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to customers_url, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def find_by_phone
    customer = Customer.where('phone = ?', params[:phone]).first
    unless customer.nil?
      appointment = Appointment.where('customer_id = ?', customer.id).order('id DESC').first
      render json: { customer: customer, appointment: appointment }, status: 200
    else
      render json: 'not found', status: 404  
    end
    
  end
  

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    authorize! :destroy, @customer

    @customer.status = 'DELETED'
    @customer.save
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :details, :phone, :email)
    end
end
