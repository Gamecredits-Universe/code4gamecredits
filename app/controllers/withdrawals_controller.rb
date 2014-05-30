class WithdrawalsController < ApplicationController
  def index
    @distributions = Distribution.order(created_at: :desc).page(params[:page]).per(30)
  end
end
