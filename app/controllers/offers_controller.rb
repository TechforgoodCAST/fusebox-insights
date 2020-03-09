# frozen_string_literal: true

class OffersController < ApplicationController
  before_action :load_project

  def show
    @offer = Offer.find_by(id: params[:id])
  end
end
