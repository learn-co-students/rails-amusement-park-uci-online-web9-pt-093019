class Ride < ActiveRecord::Base
    belongs_to :user
    belongs_to :attraction

    def take_ride 
        hash = validate_rider
        can_take_ride = hash[:can_ride]
        sorry_message = hash[:sorry_message]
        thank_you_message = "Thanks for riding the #{attraction.name}!"
        
        if can_take_ride == true 
            user.tickets -= attraction.tickets
            user.nausea += attraction.nausea_rating 
            user.happiness += attraction.happiness_rating 
            user.save 
            thank_you_message
        else 
            sorry_message
        end 
    end 

    def validate_rider 
        can_take_ride = true 
        sorry_message = ""

        if self.user.tickets < self.attraction.tickets
            can_take_ride = false  
            sorry_message = "Sorry. You do not have enough tickets to ride the #{attraction.name}."            
        end 
        if self.user.height < self.attraction.min_height             
            can_take_ride = false 
            if sorry_message.length > 1 
                sorry_message = "Sorry. You do not have enough tickets to ride the Roller Coaster. You are not tall enough to ride the Roller Coaster."
            else 
                sorry_message = "Sorry. You are not tall enough to ride the #{attraction.name}."
            end 
        end 
        {:can_ride => can_take_ride, :sorry_message => sorry_message}
    end     
end
