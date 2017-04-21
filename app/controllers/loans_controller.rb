class LoansController < ApplicationController
  def register
  end

  def create_lender
    @lender = Lender.new(lender_params)
    if @lender.save
      session[:user_id] = @lender.id
      redirect_to lender_path @lender
    else
      flash[:errors] = @lender.errors.full_messages
      redirect_to :back
    end
  end

  def create_borrower
    @borrower = Borrower.new(borrower_params)
    if @borrower.save
      session[:user_id] = @borrower.id
      redirect_to borrower_path @borrower
    else
      flash[:errors] = @borrower.errors.full_messages
      redirect_to :back
    end
  end

  def borrower_show
    @borrower = Borrower.find(params[:id])
    @lenders = History.joins(:lender).select('*').where(borrower:Borrower.find(params[:id]))
  end

  def lender_show
    @lender = Lender.find(params[:id])
    @borrowers = Borrower.all
    @lent = History.joins(:borrower).select('*').where(lender: @lender)
  end

  def lend_money
    @lender = Lender.find(session[:user_id])
  	@lender.update(money:@lender.money-params[:amount_given])
  	@borrower = Borrower.find(params[:id])
  	if @borrower.raised.nil?
  		@borrower.update(raised:params[:amount_given])
  	else
  		@borrower.update(raised:@borrower.raised + params[:amount_given])
  	end
  end

  private
  def lender_params
    params.require(:lender).permit(:first_name, :last_name, :email, :password, :money)
  end

  def borrower_params
    params.require(:borrower).permit(:first_name, :last_name, :email, :password, :money, :purpose, :description, :raised)
  end
end
