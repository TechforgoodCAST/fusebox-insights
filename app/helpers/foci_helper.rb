module FociHelper
  def next_reminder_date(date = Date.today)
    date += 1 + ((4 - date.wday) % 7)
  end
end
