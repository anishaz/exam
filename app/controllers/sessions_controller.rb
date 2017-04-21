class SessionsController < ApplicationController
  # skip_before_action :require_login, only: [:login, :create]

  def login
  end

  def create
    @user = Lender.find_by_email(params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      # if @user.nil?
      #   @user = Borrower.find_by_email(params[:user][:email])
      #   if @user && @user.authenticate(params[:user][:password])
      #     session[:user_id] = @user.id
      #     session[:user_as] = "borrower"
      #     redirect_to '/borrower/#{@user.id}'
      #   else
      #     flash[:errors] = ["Invalid Combination"]
      #     redirect_to :back
      #   end
      # end
    session[:user_id] = @user.id
    session[:user_as] = "lender"
    redirect_to lender_path(@user)
    else
      flash[:errors] = ["Invalid Combination"]
      redirect_to :back
    end
  end

  def logout
    reset_session
    redirect_to :root
  end
end
