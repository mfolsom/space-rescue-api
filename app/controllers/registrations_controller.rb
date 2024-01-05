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

    private

    def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :display_name, :credits, :level, :saved_game_state)
    end
end


