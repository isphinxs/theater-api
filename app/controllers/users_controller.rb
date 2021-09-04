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
            render json: { error: "Error creating user." }, status: :not_acceptable
        end
    end

    # def omniauth
    #     user_info = request.env["omniauth.auth"]
    #     byebug
    #     user = User.find_or_create_by(uid: user_info["uid"], provider: user_info["provider"]) do |u|
    #       u.first_name = user_info["info"]["first_name"]
    #       u.last_name = user_info["info"]["last_name"]
    #       u.email = user_info["info"]["email"]
    #       u.username = user_info["info"]["email"]
    #       u.password = SecureRandom.hex(10)
    #     end
    #     if user.valid?
    #       session[:user_id] = user.id
    #       redirect_to root_path
    #     else
    #       redirect_to signup_path, alert: "Hmm, please try signing up again."
    #     end
    # end

    # PATCH/PUT /users/1
    def update
        if @user.update(user_params)
            render json: @user, include: [:shows]
        else
            render json: { error: "Error updating user." }
        end
    end

    #DELETE /users/1
    def destroy
        if @user.destroy
            render json: { message: "User successfully deleted." }
        else
            render json: { error: "Error deleting user." }
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
