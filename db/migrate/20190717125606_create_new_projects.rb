class CreateNewProjects < ActiveRecord::Migration[5.2]
  def up
    drop_table :foci
    drop_table :proofs
    drop_table :insights
    drop_table :assumptions
    drop_table :events
    drop_table :groups
    drop_table :support_messages
    drop_table :projects, force: :cascade

    create_table :projects do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
