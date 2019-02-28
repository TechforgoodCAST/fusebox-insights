class SearchController < ApplicationController
    def index
        puts "hello"
        puts params[:search][:query]
        if params[:search][:query].present?
            @search_results = PgSearch.multisearch(params[:search][:query])

            puts @search_results.size
            
        end
    end
end