class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id 
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def show
        if session[:user_id].blank?
            redirect_to root_path
        else
            @user = User.find(params[:id])
            if !session[:user_id] == @user.id
                redirect_to root_path
            end
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :password, :height, :nausea, :happiness, :tickets, :admin)
    end
end
