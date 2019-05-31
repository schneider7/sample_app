class UsersController < ApplicationController
   before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
   before_action :set_user,       only: [:show, :edit, :update]
   before_action :correct_user,   only: [:edit, :update]
   before_action :admin_user,     only: :destroy
 

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = "You have successfully created an account!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash.now[:success] = "Profile successfully updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

      def user_params
        params.require(:user).permit(:name, :email, :password,
                                     :password_confirmation, :about)
      end  

      def logged_in_user
        unless logged_in?
          flash[:danger] = "You have to log in before you can do that action."
          redirect_to login_url
        end
      end 

      def correct_user
        redirect_to root_url unless @user == current_user
      end

      def set_user
        @user = User.find(params[:id])
      end

      def admin_user
        redirect_to root_url unless current_user.admin?
      end 
end
