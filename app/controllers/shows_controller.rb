class ShowsController < ApplicationController
    before_action :set_show, only: [:show, :update, :destroy]
    skip_before_action :authorized, only: [:index, :show]

    # GET /shows
    def index
        shows = Show.all
        render json: shows, only: [:id, :title, :theater, :director, :music, :lyrics, :book, :open_date]
    end

    # GET /shows/1
    def show
        if @show
            render json: @show, only: [:id, :title, :theater, :director, :music, :lyrics, :book, :open_date]
        else
            render json: { error: "Show not found. Please try again." }
        end
    end

    # POST /shows
    def create
        show = Show.new(show_params)
        if show.save
            render json: show, status: :created
        else
            render json: { error: "Error creating show." }
        end
    end

    # PATCH/PUT /shows/1
    def update
        if @show.update(show_params)
            render json: @show, only: [:id, :title, :theater, :director, :music, :lyrics, :book, :open_date]
        else
            render json: { error: "Error updating show." }
        end
    end

    #DELETE /shows/1
    def destroy
        if @show.destroy
            render json: { message: "Show successfully deleted." }
        else
            render json: { error: "Error deleting show." }
        end
    end

    private

    def set_show
        @show = Show.find(params[:id])
    end

    def show_params
        params.require(:show).permit(:title, :theater, :director, :music, :lyrics, :book, :open_date)
    end

end
