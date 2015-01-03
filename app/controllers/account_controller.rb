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
  end

end
