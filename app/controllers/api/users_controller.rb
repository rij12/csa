class API::UsersController < API::ApplicationController
  include UsersCommon
  
  before_action :set_current_page, except: [:index]
  before_action :set_user, only: [:show, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :show_record_not_found

  # GET /users.json
  def index
    @users = User.paginate(page: params[:page],
                           per_page: params[:per_page])
                   .order('surname, firstname')
  end

  # GET /users/1.json
  def show
  end

  # POST /users.json
  def create
    respond_to do |format|
       format.json do
         @user = User.new(user_params)
    
         # Only create a new image if the :image_file parameter
         # was specified
         @image = Image.new(photo: params[:image_file]) if params[:image_file]
    
         # The ImageService model wraps up application logic to
         # handle saving images correctly
         @service = ImageService.new(@user, @image)
         
         if @service.save # Will attempt to save user and image
           head :created, location: api_user_url(@user)
         else
           render json: @user.errors, status: :unprocessable_entity
         end
       end
    end
  end

  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      format.json do
        @image = @user.image
        @service = ImageService.new(@user, @image)
        if @service.update_attributes(user_params, params[:image_file])
          head :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /users/1.json
  def destroy
    respond_to do |format|
      format.json do
        @user.destroy
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  def show_record_not_found(exception)
    respond_to do |format|
      format.json {
        render json: '{Account no longer exists.}',
               status: :unprocessable_entity
      }
    end
  end
end
