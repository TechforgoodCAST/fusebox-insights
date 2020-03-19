class CreateSupportRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :support_requests do |t|
      t.references :requester, foreign_key: {to_table: :users}
      t.references :on_behalf_of, foreign_key: {to_table: :users}
      t.text :message
      t.references :offer, foreign_key: true

      t.timestamps
    end
  end
end
