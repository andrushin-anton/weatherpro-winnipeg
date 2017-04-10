class TelemarketersController < ApplicationController
  def index
    authorize! :telemarketers, User

    @telemarketers = User.search('telemarketer', params[:search], params[:page])
  end

  def show
  end

  def new
    authorize! :telemarketers_new, User

    @telemarketer = User.new
  end

  def edit
  end

  def create
    @telemarketer = User.new(allowed_params)

    respond_to do |format|
      if @telemarketer.save
        format.html { redirect_to telemarketers_url, notice: 'Telemarketer was successfully created.' }
        format.json { render :show, status: :created, location: @telemarketer }
      else
        format.html { render :new }
        format.json { render json: @telemarketer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @telemarketer.update(allowed_params)
        format.html { redirect_to telemarketers_url, notice: 'Telemarketer was successfully updated.' }
        format.json { render :show, status: :ok, location: @telemarketer }
      else
        format.html { render :edit }
        format.json { render json: @telemarketer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @telemarketer = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def allowed_params
      params.require(:user).permit(:email, :password, :role, :first_name, :last_name, :password_confirmation)
    end
end
