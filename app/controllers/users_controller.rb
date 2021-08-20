class UsersController < ApplicationController
    # before_action :require_authorization
    # skip_before_action :require_authorization, only: [:new, :create]
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    # GET /users/1
    def show
        render json: @user
    end

    def new
        @user = User.new
    end

    # POST /users
    def create
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { message: "Error creating show." }
        end
    end

    # PATCH/PUT /users/1
    def update
        if @user.update(user_params)
            render json: @user
        else
            render json: { message: "Error updating user." }
        end
    end

    #DELETE /users/1
    def destroy
        if @user.destroy
            render json: { message: "User successfully deleted." }
        else
            render json: { message: "Error deleting user." }
        end
    end

    private

    # def require_authorization
    #     return head(:forbidden) unless current_user == User.find_by(id: params[:id])
    # end

    def current_user
        @current_user == User.find_by(id: session[:user_id])
    end

    def set_user
        @user = current_user
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
