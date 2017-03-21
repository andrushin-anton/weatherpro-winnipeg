class InstallersController < ApplicationController
  def index
    @installers = User.search('installer', params[:search], params[:page])
  end

  def show
  end

  def new
     @installer = User.new
  end

  def edit
  end

  def create
    @installer = User.new(allowed_params)

    respond_to do |format|
      if @installer.save
        format.html { redirect_to installers_url, notice: 'Installer was successfully created.' }
        format.json { render :show, status: :created, location: @installer }
      else
        format.html { render :new }
        format.json { render json: @installer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @installer.update(allowed_params)
        format.html { redirect_to installers_url, notice: 'Installer was successfully updated.' }
        format.json { render :show, status: :ok, location: @installer }
      else
        format.html { render :edit }
        format.json { render json: @installer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @installer = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def allowed_params
      params.require(:user).permit(:email, :password, :role, :first_name, :last_name, :password_confirmation)
    end
end
