class CustomSessionsController < Devise::SessionsController
    def create
        self.resource = warden.authenticate(auth_options)
        if self.resource
        sign_in(resource_name, resource)
        yield resource if block_given?
        render json: {
            id: resource.id,
            email: resource.email,
            credits: resource.credits,
            level: resource.level,
            saved_game_state: resource.saved_game_state,
            display_name: resource.display_name
        }
        else
        render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
    end

    protected

    def auth_options
        { scope: resource_name, recall: "#{controller_path}#new" }
    end
end
