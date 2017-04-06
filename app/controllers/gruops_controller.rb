class GruopsController < ApplicationController
  before_action :set_gruop, only: [:show, :edit, :update, :destroy]
  before_action :set_notifications
  # GET /gruops
  # GET /gruops.json
  def index
    @notifications = @user.notifications.reverse
    @user = User.find params[:user_id]
    @gruops = @user.gruops.all
  end

  # GET /gruops/1
  # GET /gruops/1.json
  def show
    @notifications = @user.notifications.reverse
   @users = User.all
  end

  # GET /gruops/new
  def new
    @notifications = @user.notifications.reverse
    @user = User.find params[:user_id]
    @gruop = @user.gruops.new
  end

  # GET /gruops/1/edit
  def edit
    @notifications = @user.notifications.reverse
  end

  # POST /gruops
  # POST /gruops.json
  def create
    @notifications = @user.notifications.reverse
    @user = User.find params[:user_id]
    @gruop = @user.gruops.new(gruop_params)

    respond_to do |format|

      if @gruop.save
         @member = @gruop.members.new(user_id: @user.id)
         @member.save
        format.html { redirect_to [@user,@gruop], notice: 'Gruop was successfully created.' }
        format.json { render :show, status: :created, location: @gruop }
      else
        format.html { render :new }
        format.json { render json: @gruop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gruops/1
  # PATCH/PUT /gruops/1.json
  def update
    respond_to do |format|
      if @gruop.update(gruop_params)
        format.html { redirect_to [@user,@gruop], notice: 'Gruop was successfully updated.' }
        format.json { render :show, status: :ok, location: @gruop }
      else
        format.html { render :edit }
        format.json { render json: @gruop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gruops/1
  # DELETE /gruops/1.json
  def destroy
    @gruop.destroy
    respond_to do |format|
      format.html { redirect_to gruops_url, notice: 'Gruop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gruop
      @user = User.find(params[:user_id])
      @gruop = @user.gruops.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gruop_params
      params.require(:gruop).permit(:name, :user_id)
    end
    def set_notifications
      @user=current_user
      @notifications = @user.notifications.all.reverse
    end
end
