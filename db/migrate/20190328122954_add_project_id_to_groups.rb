class AddProjectIdToGroups < ActiveRecord::Migration[5.2]
  def change
    add_reference :groups, :project, foreign_key: true
  end
end
