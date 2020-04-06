class AttractionsController < ApplicationController

    def index 
        @attractions = Attraction.all 
        if current_user.admin == true 
            @admin = current_user
        end 
    end 

    def show
        @attraction = Attraction.find_by(id: params[:id])
        @ride = @attraction.rides.build(user_id: current_user.id)    
        if current_user.admin == true 
            @admin = current_user
        end    
    end 

    def new
        @attraction = Attraction.new 
    end 

    def create
        @attraction = Attraction.create(attraction_params)
        redirect_to attraction_path(@attraction)
    end 

    def edit
        @attraction = Attraction.find_by(params[:id])
    end 

    def update 
        @attraction = Attraction.find_by(params[:id])
        @attraction.update(attraction_params)
        redirect_to attraction_path(@attraction)
    end 

    private 

    def attraction_params
        params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height)
    end 
end
