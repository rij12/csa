class UsersController < ApplicationController
  include UsersCommon
  
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
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
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
        format.html { redirect_to(user_url(@user, page: @current_page),
                                  notice: 'Account was successfully created.') }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    @image = @user.image
    @service = ImageService.new(@user, @image)

    respond_to do |format|
      if @service.update_attributes(user_params, params[:image_file])
        format.html { redirect_to(user_url(@user, page: @current_page),
                                  notice: 'Account was successfully updated.') }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url(page: @current_page) }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  def show_record_not_found(exception)
    respond_to do |format|
      format.html {
        redirect_to(users_url(page: @current_page),
                    notice: 'Account no longer exists.')
      }
    end
  end
end
