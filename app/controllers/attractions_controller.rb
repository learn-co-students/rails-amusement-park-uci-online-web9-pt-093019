class AttractionsController < ApplicationController
    def index
        @attractions = Attraction.all
    end

    def new
        @attraction = Attraction.new
    end

    def create
        @attraction = Attraction.new(attraction_params)
        if @attraction.save
            redirect_to attraction_path(@attraction)
        else
            render :new
        end
    end

    def show
        @attraction = Attraction.find(params[:id])
    end

    def edit
        @attraction = Attraction.find(params[:id])
    end

    def update
        @attraction = Attraction.find(params[:id])
        if @attraction.update(attraction_params)
            redirect_to attraction_path(@attraction)
        else
            render :edit
        end        
    end

    def ride
        @ride = Ride.new(ride_params)
        if @ride.save
            @message = @ride.take_ride
            @user = @ride.user
            redirect_to user_path(@user), alert: @message
        else
            attractions_path
        end
    end

    private

    def ride_params
        params.require(:ride).permit(:user_id, :attraction_id)
    end

    def attraction_params
        params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height)
    end
end
