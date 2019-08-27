class CreateNewProjects < ActiveRecord::Migration[5.2]
  def up
    drop_table :foci
    drop_table :proofs
    drop_table :insights
    drop_table :comments
    drop_table :assumptions
    drop_table :events
    drop_table :groups
    drop_table :support_messages
    drop_table :projects, force: :cascade
    drop_table :pg_search_documents

    Membership.destroy_all

    create_table :projects do |t|
      t.string :title, null: false
      t.text :description
      t.text :more_details

      t.timestamps
    end
  end
end
