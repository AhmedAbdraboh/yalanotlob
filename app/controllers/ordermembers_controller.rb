class OrdermembersController < ApplicationController
  before_action :set_ordermember, only: [ :show, :edit, :update, :destroy]

  # GET /ordermembers
  # GET /ordermembers.json
  def index
    @notifications = Notification.all.reverse
    @ordermembers = Ordermember.all
  end

  # GET /ordermembers/1
  # GET /ordermembers/1.json
  def show

  end

  # GET /ordermembers/new
  def new
    # byebug
    @users = params[:usersToSend]

    @user = User.find params[:user_id]
    @order = Order.find params[:order_id]
    @ordermember = @order.ordermembers.new
  end

  # GET /ordermembers/1/edit
  def edit
    @ordermember.status="joined"
  end

  # POST /ordermembers
  # POST /ordermembers.json
  def create
    # @user=current_user
    # @order=Order.find(params[:order_id])
    @ordermember = Ordermember.new(ordermember_params)

    @order=@ordermember.order
    @ordermembers=@order.ordermembers
    @duplicatedMember = @ordermembers.select{ |ordermember| ordermember.status == "joined" && ordermember.user.id==@ordermember.user.id && ordermember.order.id==@ordermember.order.id}
    # @ordermember.user_id = @user.id
    if @duplicatedMember
      @ordermember.status="duplicated"
    else
      @ordermember.status="joined"
    end

    respond_to do |format|
      if @ordermember.save
        format.html { redirect_to user_order_path(@ordermember.order.user,@ordermember.order), notice: 'Ordermember was successfully created.' }
        format.json { render :show, status: :created, location: @ordermember }
      else
        format.html { render :new }
        format.json { render json: @ordermember.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ordermembers/1
  # PATCH/PUT /ordermembers/1.json
  def update

    respond_to do |format|
      if @ordermember.update(ordermember_params)
        format.html { redirect_to @ordermember, notice: 'Ordermember was successfully updated.' }
        format.json { render :show, status: :ok, location: @ordermember }
      else
        format.html { render :edit }
        format.json { render json: @ordermember.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ordermembers/1
  # DELETE /ordermembers/1.json
  def destroy
    @ordermember.destroy
    respond_to do |format|
      format.html { redirect_to ordermembers_url, notice: 'Ordermember was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ordermember
      @ordermember = Ordermember.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ordermember_params
      params.require(:ordermember).permit(:user_id, :order_id, :status, :item, :amount, :price, :comment)
    end
end
