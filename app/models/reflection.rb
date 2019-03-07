# frozen_string_literal: true

class Reflection
  include ActiveModel::Model

  attr_accessor :author, :responses

  def initialize(*args)
    super(*args)
    @responses = unknowns.map { Response.new } if @responses.blank?
  end

  def save
    if @responses.is_a?(Hash)
      @responses = @responses.map do |k, v|
        Response.new(v.merge(author: author, unknown: unknowns[k.to_i], type: 'insight'))
      end
    end

    if responses.map(&:valid?).all?
      responses.each(&:save)
    else
      false
    end
  end

  def unknowns
    author&.in_focus || []
  end
end
