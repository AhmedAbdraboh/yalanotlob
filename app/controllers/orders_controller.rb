class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :invitedfriends, :joinedfriends]
  before_action :set_notifications
  # GET /orders
  # GET /orders.json
  def index


    # byebug
    # @userOfOrder = User.find params[:user_id]
    @orders = @user.orders

  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @user = current_user
    @ordermember = Ordermember.new
    @ordermember.order = @order
    @ordermember.user=@user
    @currentOrderMembers = @order.ordermembers
    @invitedMembers = @currentOrderMembers.select{ |ordermember| ordermember.status == "invited"}
    @joinedMembers = @currentOrderMembers.select{ |ordermember| ordermember.status == "joined"}

  end

  # GET /orders/new
  def new
    @notifications = Notification.all.reverse
    @user = current_user
    @order = @user.orders.new
  end

  # GET /orders/1/edit
  def edit
    @user = current_user
    # byebug

    finishOrder={ name: @order.name, restaurant: @order.restaurant, status: "finished", avatar: @order.avatar}
    @order.update(finishOrder)
    redirect_to user_orders_path(@user)
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
            Notification.create(event: "#{@order.user.name} invited you to his order", user: @user, order: @order)
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
    # @user = current_user
    # @order.destroy
    # respond_to do |format|
    #   format.html { redirect_to user_orders_path(@order), notice: 'Order was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
    @user = current_user
    # byebug

    finishOrder={ name: @order.name, restaurant: @order.restaurant, status: "cancelled", avatar: @order.avatar}
    @order.update(finishOrder)
    redirect_to user_orders_path(@user)
  end
  def invitedfriends
      @currentOrderMembers = @order.ordermembers
      @ordermembers = @currentOrderMembers.select{ |ordermember| ordermember.status == "invited"}
  end
  def joinedfriends
      @currentOrderMembers = @order.ordermembers
      @ordermembers = @currentOrderMembers.select{ |ordermember| ordermember.status == "joined"}
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @notifications = Notification.all.reverse
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :restaurant, :status, :avatar)
    end
    def set_notifications
      @user=current_user
      @notifications = @user.notifications.all.reverse
    end
end
