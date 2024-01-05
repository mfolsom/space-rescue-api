class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_user, only: [:show, :update]

    def index
        users = User.all
        render json: users, status: :ok
    end

    def show
        render json: @user, status: :ok
    end

    def update
        if @user.update(user_params)
        render json: @user, status: :ok
        else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def set_user
        @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { error: "User not found" }, status: :not_found
    end

    def user_params
        params.require(:user).permit(:email, :credits, :level, :saved_game_state, :display_name)
    end
end
