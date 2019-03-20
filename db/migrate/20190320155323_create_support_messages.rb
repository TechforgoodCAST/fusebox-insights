class CreateSupportMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :support_messages do |t|
      t.string :status
      t.int :order
      t.text :body

      t.timestamps
    end
  end
end
