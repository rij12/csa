# Handles incoming user account HTTP requests
# @author Chris Loftus
class UsersController < ApplicationController
  before_action :set_current_page, except: [:index]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :show_record_not_found

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page],
                           per_page: params[:per_page])
                 .order('surname, firstname')
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @user.user_detail = UserDetail.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    # Only create a new image if the :image_file parameter
    # was specified
    @image = Image.new(photo: params[:image_file]) if params[:image_file]

    # The ImageService model wraps up application logic to
    # handle saving images correctly
    @service = ImageService.new(@user, @image)

    respond_to do |format|
      if @service.save # Will attempt to save user and image
        format.html {redirect_to(user_url(@user, page: @current_page),
                                 notice: 'Account was successfully created.')}
        format.json {render :show, status: :created, location: @user}
      else
        format.html {render :new}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @image = @user.image
    @service = ImageService.new(@user, @image)

    respond_to do |format|
      if @service.update_attributes(user_params, params[:image_file])
        format.html {redirect_to(user_url(@user, page: @current_page),
                                 notice: 'Account was successfully updated.')}
        format.json {render :show, status: :ok, location: @user}
      else
        format.html {render :edit}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html {redirect_to users_url(page: @current_page)}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def set_current_page
    @current_page = params[:page] || 1
  end

  def show_record_not_found(exception)
    respond_to do |format|
      format.html {
        redirect_to(users_url(page: @current_page),
                    notice: 'Account no longer exists.')
      }
      format.json {
        render json: '{Account no longer exists.}',
               status: :unprocessable_entity
      }
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:surname, :firstname, :phone, :grad_year, :jobs, :email, user_detail_attributes: [:id, :password, :password_confirmation, :login])
  end
end
