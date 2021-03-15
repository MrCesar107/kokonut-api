class CreateOmniauthProviders < ActiveRecord::Migration[6.1]
  def change
    create_table :omniauth_providers do |t|
      t.references :user, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.string :oauth_response

      t.timestamps
    end
  end
end
