class Scheduler
  def call
    Time.zone = 'Japan'
    slots = []
    day = 0
    weekday_hours = [12, 13, 14, 22, 23]
    weekend_hours = [22, 23]
    until day >= 7
      date = Date.today.in_time_zone.beginning_of_day + day.days
      hours = day >= 5 ? weekend_hours : weekday_hours
      hours.each { |hour| slots << date + hour.hours }
      day += 1
    end
    next_week_events = CalendarReader.new.next_week_events.map { |event| event.dtstart.to_i..event.dtend.to_i }
    slots.map(&:utc).reject{}.map(&:in_time_zone)
    next_week_events
  end
end
