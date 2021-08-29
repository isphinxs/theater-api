class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    # GET /users/1
    def show
        render json: @user, include: [:shows]
    end

    # POST /users
    def create
        user = User.new(user_params)
        # byebug
        if user.valid?
            user.save
            token = encode_token(user_id: user.id)
            render json: { user: user, jwt: token }, status: :created
        else
            render json: { message: "Error creating user." }, status: :not_acceptable
        end
    end

    # PATCH/PUT /users/1
    def update
        if @user.update(user_params)
            render json: @user, include: [:shows]
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

    def set_user
        @user = current_user
        # @user = User.find_by(id: 1)
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, show_ids: [])
    end
end
