class UsersController < ApplicationController
    def index
        @users = User.all
        @user  = User.new
    end
    
    def show
        @user = User.find(params[:id])
    end
    
    def new
        @user = User.new
    end
    

    def create
        source = params[:user][:source]
        @user = User.new(user_params)
        
        if @user.save
            respond_to do |format|
                if source == "index"
                    format.turbo_stream
                else
                    format.html { redirect_to users_path }
                end
            end
        else
            render :index, status: :unprocessable_entity
        end
    end
    
    private
    
    def user_params
        params.require(:user).permit(:name, :email)
    end
end