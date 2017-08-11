# Controller for user accounts
# @author Chris Loftus
class UsersController < ApplicationController
  before_action :set_current_page, except: [:index]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :show_record_not_found

  def search
    @users = User.like(params[:query])
             .paginate(page: params[:page],
                           per_page:  params[:per_page])
             .order('surname, firstname')
    if request.xhr?
      render partial: 'users_list',
              object: @users,
              layout: false
    else
      render 'index'
    end   

  end

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
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to(user_url(@user, page: @current_page),
                                  notice: 'Account was successfully created.') }
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
        format.html { redirect_to(user_url(@user, page: @current_page),
                                  notice: 'Account was successfully updated.') }
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
      format.html { redirect_to users_url(page: @current_page) }
      format.json { head :no_content }
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
    params.require(:user).permit(:surname, :firstname, :phone, :grad_year, :jobs, :email)
  end
end
