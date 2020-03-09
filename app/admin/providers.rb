# frozen_string_literal: true

ActiveAdmin.register Provider do
  permit_params :name, :website

  index do
    selectable_column
    id_column
    column :name
    column :website
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :website
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :website
    end
    f.actions
  end
end
