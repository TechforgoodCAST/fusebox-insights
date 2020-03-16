# frozen_string_literal: true

ActiveAdmin.register Offer do
  permit_params :provider_id, :title, :short_description, :long_description,
                :sign_up_link, :logo_link, :duration_category, :provider_email,
                :duration_description, cohort_ids: [], topic_ids: []

  index do
    selectable_column
    column :provider
    column :title
    column :cohorts
    column :topics
    column :updated_at
    actions
  end

  filter :provider
  filter :title
  filter :cohorts
  filter :topics
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :cohorts
      f.input :topics
      f.input :provider
      f.input :provider_email
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
