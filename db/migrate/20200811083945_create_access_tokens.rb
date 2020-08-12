class CreateAccessTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :access_tokens do |t|
      t.string :access_token
      t.boolean :keep_alive, default: false
      t.string :status, default: 'active'

      t.timestamps
    end
  end
end
