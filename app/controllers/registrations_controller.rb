class RegistrationsController < Devise::RegistrationsController
    def create
        build_resource(sign_up_params)

        resource.save
        if resource.persisted?
            if resource.active_for_authentication?
                sign_up(resource_name, resource)
                render json: resource, status: :created
            else
                expire_data_after_sign_in!
                render json: resource, status: :ok
            end
        else
            clean_up_passwords resource
            set_minimum_password_length
            render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update_credits
        user = User.find(params[:id])
        if user.update(credits: params[:credits])
            render json: user, status: :ok
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :display_name)
        # Removed :credits, :level, and :saved_game_state from permitted parameters
    end
end



