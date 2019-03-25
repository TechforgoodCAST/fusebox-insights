class SearchController < ApplicationController
    def index
        if params[:search][:query].present?
            @search_results = PgSearch.multisearch(params[:search][:query])            
        end
    end
end