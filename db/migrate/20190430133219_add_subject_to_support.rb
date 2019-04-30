class AddSubjectToSupport < ActiveRecord::Migration[5.2]
  def change
    add_column :support_messages, :subject, :string
  end
end
