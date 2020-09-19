class Scheduler
  def call
    next_week_events = CalendarReader.new.next_week_events
    p next_week_events.map { |event| event.dtstart..event.dtend }
  end
end
