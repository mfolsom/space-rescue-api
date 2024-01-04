class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.integer :credits
      t.integer :level
      t.text :saved_game_state

      t.timestamps
    end
  end
end
