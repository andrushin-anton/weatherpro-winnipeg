class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end  

  def password
    @user = User.find(params[:id])
  end  

  def update_password
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(allowed_params)
        format.html { redirect_to redirect_to_back, notice: 'Password was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :password }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @user = User.new(allowed_params)
    if @user.save
      redirect_to root_url, notice: 'Thank you for signing up!'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(allowed_params)
        format.html { redirect_to redirect_to_back, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def activate
    @user = User.find(params[:id])
    @user.status = 'ACTIVE'
    @user.save
    respond_to do |format|
      format.html { redirect_to redirect_to_back, notice: 'User was successfully activated.' }
      format.json { head :no_content }
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.status = 'DELETED'
    @user.save
    respond_to do |format|
      format.html { redirect_to redirect_to_back, notice: 'User was successfully disabled.' }
      format.json { head :no_content }
    end
  end

  private

    def redirect_to_back(default = root_url)
      if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
        :back
      else
        default
      end
    end

    def allowed_params
      params.require(:user).permit(:email, :password, :status, :role, :first_name, :last_name, :password_confirmation)
    end
end
