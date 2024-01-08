class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  # Validation for display_name
  validates :display_name, presence: true

  # Set default values for new users
  after_initialize :set_default_values, if: :new_record?

  private

  def set_default_values
    self.credits ||= 100  # Set default credits to 100 if not provided
    self.level ||= 1      # Set default level to 1 if not provided
    # The saved_game_state can be initialized here if needed
  end

  # Any other custom fields or methods can be added here.
end

