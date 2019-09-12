# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1280, 700]

  def sign_in(user = @user)
    fill_in(:user_email, with: user.email)
    fill_in(:user_password, with: user.password)
    click_button('Sign in')
  end

  def sign_out
    click_on('Sign out')
  end
  
  def friendly_date(date)
    raise "#{date} is a #{date.class} and not a date" unless date.respond_to?(:strftime)

    date.strftime("#{date.day.ordinalize} %b %Y")
  end
end
