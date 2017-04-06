class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def index
    #@notifications = @user.notifications.reverse
    @notifications = Notification.all.reverse
    @users = User.all
    @users = User.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @users.map(&:name)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    #@notifications = Notification.all.reverse
    @notifications = Notification.all.reverse
  end

  # GET /users/new
  def new
    #@notifications = @user.notifications.reverse
    @notifications = Notification.all.reverse
    layout false
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    #@notifications = @user.notifications.reverse
    @notifications = Notification.all.reverse
    layout false
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_friend
  @user = User.find(params[:id])
  @friend = current_user
  @user.remove_friend(@friend)
  redirect_to :search


	

  end
  #1-add friend
  def addFriend
	@user = User.find_by_email(params[:email])
	@friend = current_user
	@user.friend_request(@friend)
  @friend.requested_friends
  end

#   def pendingFriend
#     friend = User.find_by_email(params[:email])
#     @friend_request=current_user.friend_request.new(friend: friend)
#     @sender.friend_request(@friend_request)
#     @sender.pending_friends
#   #   if @friend_request.save
#   #   redirect_back(fallback_location: root_path), status: :created, location: @friend_request
#   #
#   # end
# end
  def index_friends
	@user = current_user
	render :friends


  end
def accept_friends
  @friend = User.find(params[:id])
  @user = current_user
  @user.friend_request(@friend)
  @user.accept_request(@friend)

redirect_to :search
end

def decline_friends
  @user = User.find(params[:id])
  @friend = current_user
  @user.decline_request(@friend)
  redirect_to :search

end

def remove_friends
  @friend = User.find(params[:id])
  @user = current_user
  @user.remove_friend(@friend)
  redirect_to :search

end

  # private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :email, :avatar)
    end

   

end 



