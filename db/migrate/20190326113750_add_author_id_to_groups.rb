class AddAuthorIdToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :author_id, :bigint, index: true, null: false
  end
end
