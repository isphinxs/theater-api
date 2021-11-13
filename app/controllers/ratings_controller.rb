class RatingsController < ApplicationController
    before_action :set_rating, only: [:show, :update, :destroy]
    skip_before_action :authorized, only: [:index, :show]

    # GET /ratings
    def index
        ratings = Rating.all
        render json: ratings, only: [:id, :user_id, :show_id, :rating]
    end
    
    # GET /ratings/1
    def show
        if @rating
            render json: rating, only: [:id, :user_id, :show_id, :rating]
        else
            render json: { error: "Rating not found. Please try again." }
        end
    end
    
    # POST /ratings
    def create
        rating = Rating.new(comment_params)
        if rating.save
            render json: rating, status: :created
        else
            render json: { error: "Error creating rating." }
        end
    end
    
    # PATCH/PUT /ratings/1
    def update
        if @rating.update(rating_params)
            render json: @rating, only: [:id, :user_id, :show_id, :rating]
        else
            render json: { error: "Error updating rating." }
        end
    end

    #DELETE /ratings/1
    def destroy
        if @show.destroy
            render json: { message: "Rating successfully deleted." }
        else
            render json: { error: "Error deleting rating." }
        end
    end

    private

    def set_rating
        @rating = Rating.find(params[:id])
    end

    def comment_params
        params.require(:rating).permit(:user_id, :show_id, :rating)
    end
end
