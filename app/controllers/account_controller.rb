class AccountController < ApplicationController
  before_action :require_login
  before_filter :leftbar

  def leftbar
    @current_page = "account"
  end

  def index
    @accounts = Account.order(id: :desc).all
    render 'index'
  end

  def new
    @account = Account.new
    @accountfb = AccountFb.new
  end

  def create_from_facebook
    @accountfb = AccountFb.new(accountfb_params)    # Not the final implementation!
    puts @accountfb.inspect
    @accountfb.generate_account
    redirect_to account_index_path
  end

  private

    def accountfb_params
      if signed_in? && current_user.is_admin
        params.require(:account_fb).permit(:login,:password)
      else
        params.require(:account_fb).permit(:login, :password)
      end
    end

end
