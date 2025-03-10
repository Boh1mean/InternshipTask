class CreateAuthTokens < ActiveRecord::Migration[8.0]
  def change
    create_table :auth_tokens do |t|
      t.string :bearer, null: false
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
    add_index :auth_tokens, :bearer, unique: true
  end
end
