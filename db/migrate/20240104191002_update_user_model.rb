class UpdateUserModel < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :username, :string
    remove_column :users, :password_digest, :string
    add_column :users, :display_name, :string
  end
end

