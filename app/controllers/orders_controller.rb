class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    @user = User.find params[:user_id]

  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @user = current_user
    @order = @user.orders.new
  end

  # GET /orders/1/edit
  def edit
    @user = current_user
  end

  # POST /orders
  # POST /orders.json
  def create
    # puts(order_params)
    # byebug
    @user = current_user
    @order = @user.orders.new(order_params)
    if params[:users_to_send]
      usersInvited = params[:users_to_send].split(",")
      usersInvited.push(@user.name)
    end
    @order.status="waiting"
    # byebug

    respond_to do |format|
      if @order.save
        if params[:users_to_send]
          for oneUser in usersInvited
            @user=User.find_by_name(oneUser)
            newOrderMember={ order_id: @order.id, user_id: @user.id, status: "invited"}
            # puts(newOrderMember)
            @order.ordermembers.create(newOrderMember)
            # byebug
          end
        end

        format.html { redirect_to user_order_path(@order.user,@order), notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to user_order_path(@order.user,@order), notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params

      params.require(:order).permit(:name, :restaurant, :status, :avatar)


    end
end
