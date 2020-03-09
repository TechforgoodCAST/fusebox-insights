# frozen_string_literal: true

ActiveAdmin.register Offer do
  permit_params :provider_id, :title, :short_description, :long_description,
                :sign_up_link, :logo_link, :duration_category,
                :duration_description

  index do
    selectable_column
    id_column
    column :title
    column :created_at
    column :updated_at
    actions
  end

  filter :title
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :provider, collection: Provider.all
      f.input :title
      f.input :duration_category
      f.input :duration_description
      f.input :sign_up_link
      f.input :logo_link
      f.input :short_description, as: :trix_editor
      f.input :long_description, as: :trix_editor
    end
    f.actions
  end
end
