class OrdersController < ApplicationController
  # current_user orders
  before_action :set_order, only: %i[show update]

  def index
    @orders = @my_orders.order(created_at: :desc)
  end

  def show; end

  def update
    # change status (pay)
    respond_to do |format|
      if @order.update(order_params)
        notice_text = if order_params[:status].present?
                        'Ordered!'
                      else
                        "Your rating: #{order_params[:rating]}"
                      end
        format.html { redirect_to order_url(@order), notice: notice_text }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_order
    @order = @my_orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status, :rating)
  end
end
