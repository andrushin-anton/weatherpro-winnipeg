class AdministratorsController < ApplicationController
  def index
    authorize! :administrators, User

    @administrators = User.search('admin', params[:search], params[:page])
  end

  def show
    authorize! :administrators_show, @user
  end

  def new
    authorize! :administrators_new, User    
    @administrator = User.new
  end

  def edit
  end

  def create
    authorize! :administrators_create, User

    @administrator = User.new(allowed_params)

    respond_to do |format|
      if @administrator.save
        format.html { redirect_to administrators_url, notice: 'Administrator was successfully created.' }
        format.json { render :show, status: :created, location: @administrator }
      else
        format.html { render :new }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :administrators_update, @administrator

    respond_to do |format|
      if @administrator.update(allowed_params)
        format.html { redirect_to administrators_url, notice: 'Administrator was successfully updated.' }
        format.json { render :show, status: :ok, location: @administrator }
      else
        format.html { render :edit }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @administrator = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def allowed_params
      params.require(:user).permit(:email, :password, :role, :first_name, :last_name, :password_confirmation)
    end
end
