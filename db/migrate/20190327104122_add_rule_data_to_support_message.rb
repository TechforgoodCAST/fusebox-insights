class AddRuleDataToSupportMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :support_messages, :rule_object_type, :string, default: 'None'
    add_column :support_messages, :rule_event_type, :string, default: 'create'
    add_column :support_messages, :rule_occurrences, :int, default: 1
  end
end
