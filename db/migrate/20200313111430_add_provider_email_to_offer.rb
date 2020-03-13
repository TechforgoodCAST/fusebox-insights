class AddProviderEmailToOffer < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :provider_email, :string
  end
end
