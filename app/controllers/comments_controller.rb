class CommentsController < ApplicationController
    before_action :set_comment, only: [:show, :update, :destroy]
    skip_before_action :authorized, only: [:index, :show]

    # GET /comments
    def index
        comments = Comment.all
        render json: comments, only: [:id, :user_id, :show_id, :comment]
    end
    
    # GET /comments/1
    def show
        if @comment
            render json: comment, only: [:id, :user_id, :show_id, :comment]
        else
            render json: { error: "Comment not found. Please try again." }
        end
    end
    
    # POST /comments
    def create
        comment = Comment.new(comment_params)
        if comment.save
            render json: comment, status: :created
        else
            render json: { error: "Error creating comment." }
        end
    end
    
    # PATCH/PUT /comments/1
    def update
        if @comment.update(comment_params)
            render json: @comment, only: [:id, :user_id, :show_id, :comment]
        else
            render json: { error: "Error updating comment." }
        end
    end

    #DELETE /comments/1
    def destroy
        if @show.destroy
            render json: { message: "Comment successfully deleted." }
        else
            render json: { error: "Error deleting comment." }
        end
    end

    private

    def set_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:user_id, :show_id, :comment)
    end
end
