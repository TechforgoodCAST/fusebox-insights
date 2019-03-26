# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    if params[:search][:query].present?
      @search_results = PgSearch.multisearch(params[:search][:query])
    else
      redirect_to root_path
    end
  end
end
