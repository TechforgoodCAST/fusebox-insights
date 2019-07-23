class CreateNewProjects < ActiveRecord::Migration[5.2]
  def up
    drop_table :projects, force: :cascade

    create_table :projects do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
