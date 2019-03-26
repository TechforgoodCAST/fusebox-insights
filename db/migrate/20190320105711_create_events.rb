class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :triggerable, polymorphic: true, index: true
      t.references :project, foreign_key: true
      t.string :event_type, :null => false
      t.timestamps
    end
  end
end
