class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name, null: false, default: true
      t.bigint :user_id, index: true, null: false

      t.timestamps
    end
  end
end
