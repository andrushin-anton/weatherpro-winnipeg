class SellersController < ApplicationController
  def index
    @sellers = User.search('seller', params[:search], params[:page])
  end

  def show
  end

  def new
     @seller = User.new
  end

  def edit
  end

  def create
    @seller = User.new(allowed_params)

    respond_to do |format|
      if @seller.save
        format.html { redirect_to sellers_url, notice: 'Seller was successfully created.' }
        format.json { render :show, status: :created, location: @seller }
      else
        format.html { render :new }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @seller.update(allowed_params)
        format.html { redirect_to sellers_url, notice: 'Seller was successfully updated.' }
        format.json { render :show, status: :ok, location: @seller }
      else
        format.html { render :edit }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @seller = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def allowed_params
      params.require(:user).permit(:email, :password, :role, :first_name, :last_name, :password_confirmation)
    end
end
