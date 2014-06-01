class DistributionsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :distribution, :through => :project

  def index
    @distributions = @distributions.order(created_at: :desc).page(params[:page]).per(30)
  end

  def new
  end

  def recipient_suggestions
    render layout: nil
  end

  def create
    @distribution.project = @project
    finalize_distribution
    if @distribution.save
      redirect_to [@project, @distribution], notice: "Distribution created"
    else
      render "new"
    end
  end

  def edit
  end

  def update
    @distribution.attributes = distribution_params
    finalize_distribution
    if @distribution.save
      redirect_to [@project, @distribution], notice: "Distribution updated"
    else
      render "edit"
    end
  end

  def show
  end

  def send_transaction
    @distribution.send_transaction!
    redirect_to [@project, @distribution], flash: {notice: "Transaction sent"}
  rescue RuntimeError => e
    redirect_to [@project, @distribution], flash: {error: e.message}
  end

  private

  def distribution_params
    params.require(:distribution).permit(tips_attributes: [:id, :coin_amount, :user_id, {user_attributes: [:email]}])
  end

  def finalize_distribution
    @distribution.tips.each do |tip|
      tip.project = @project
      if tip.user.new_record?
        tip.user.skip_confirmation_notification!
      end
    end
  end
end
