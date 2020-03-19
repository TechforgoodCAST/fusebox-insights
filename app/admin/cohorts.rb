# frozen_string_literal: true

ActiveAdmin.register Cohort do
  permit_params :name, :description, project_ids: []

  index do
    selectable_column
    column :name
    column :description
    column :projects
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :description
  filter :projects
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :projects
    end
    f.actions
  end
end
