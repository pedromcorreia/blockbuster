class PurchasesController < ApplicationController
  before_action :set_user
  before_action :set_purchase, only: [:show]

  # GET /users/:user_id/purchases
  def index
    @purchases = @user.purchases.available
    render jsonapi: @purchases
  end

  # POST /users/:user_id/purchases
  def create
    @purchase = @user.purchases.new(purchase_params)

    if @purchase.save

      render jsonapi: @purchase, status: :created
    else
      render json: @purchase.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_purchase
    @purchase = @user.purchases.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def purchase_params
    params.require(:purchase).permit(:quality, :price, :purchaseble_id, :purchaseble_type, :user_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
