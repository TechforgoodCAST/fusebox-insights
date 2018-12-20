# frozen_string_literal: true

class Reflection
  include ActiveModel::Model

  attr_accessor :author, :comments

  def initialize(*args)
    super(*args)
    @comments = unknowns.map { Comment.new } if @comments.blank?
  end

  def save
    if @comments.is_a?(Hash)
      @comments = @comments.map do |k, v|
        Comment.new(v.merge(author: author, unknown: unknowns[k.to_i]))
      end
    end

    if comments.map(&:valid?).all?
      comments.each(&:save)
    else
      false
    end
  end

  def unknowns
    author&.in_focus || []
  end
end
