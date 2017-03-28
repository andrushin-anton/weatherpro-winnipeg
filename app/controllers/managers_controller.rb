class ManagersController < ApplicationController
  def index
    authorize! :managers, User

    @managers = User.search('manager', params[:search], params[:page])
  end

  def show
    authorize! :manager_show, @manager
  end

  def new
    authorize! :manager_new, User
    
    @manager = User.new
  end

  def edit
  end

  def create
    @manager = User.new(allowed_params)

    respond_to do |format|
      if @manager.save
        format.html { redirect_to managers_url, notice: 'Manager was successfully created.' }
        format.json { render :show, status: :created, location: @manager }
      else
        format.html { render :new }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @manager.update(allowed_params)
        format.html { redirect_to managers_url, notice: 'Manager was successfully updated.' }
        format.json { render :show, status: :ok, location: @manager }
      else
        format.html { render :edit }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @manager = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def allowed_params
      params.require(:user).permit(:email, :password, :role, :first_name, :last_name, :password_confirmation)
    end
end
