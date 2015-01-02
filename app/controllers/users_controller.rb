# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  before_filter :leftbar

  def leftbar
    @current_page = "user"
  end

  def new
    @user = User.new
  end

  def show
    if !current_user.nil? && (current_user.id == params[:id].to_i || current_user.is_admin)
      @user = User.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      #sign_in @user
      c = ContactForm.new(:email => @user.email, :subject => "New user", :message => "A new user has subscribed, please activate him: "+@user.name)
      if c.deliver
        flash[:warning] = "Thanks for your registration, please wait for an admin to activate your account."
      else
        flash[:danger] = "Your account has been created, but we have not been able to tell the administration. Please contact him at: maxime@argaus.fr"
      end
      redirect_to signin_path
    else
      render 'new'
    end
  end

  def update
    if signed_in?
      if current_user.is_admin
        @user = User.find(params[:id])
      else
        @user = current_user
      end
      @user.update(user_params)
      if @user.save
        flash[:success] = "Update: success"
        redirect_to @user and return
      end
    end
    flash[:danger] = "Update: error"
    redirect_to(show) and return
  end

  private

    def user_params
      if signed_in? && current_user.is_admin
        params.require(:user).permit(:name, :firstname, :login, :password, :password_confirmation, :is_admin, :is_active)
      else
        params.require(:user).permit(:name, :firstname, :login, :password, :password_confirmation)
      end
    end

end
