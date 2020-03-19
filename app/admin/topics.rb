# frozen_string_literal: true

ActiveAdmin.register Topic do
  permit_params :title, :short_desc, :long_desc

  index do
    selectable_column
    column :title
    column :short_desc
    column :long_desc
    column :created_at
    column :updated_at
    actions
  end

  filter :title
  filter :short_desc
  filter :long_desc
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :short_desc
      f.input :long_desc
    end
    f.actions
  end
end
