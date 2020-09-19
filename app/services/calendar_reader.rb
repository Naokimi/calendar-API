class CalendarReader
  def initialize
    @calendars = [ENV['PRIVATE_CALENDAR'], ENV['ODAIBA_CALENDAR']]
  end

  def next_week_events
    events = []
    @calendars.each do |calendar|
      cal = Icalendar.parse(open(calendar).read).first
      cal.events.each do |event|
        events << event if event.dtstart > Time.now && event.dtstart < Time.now + 7.days
      end
    end
    events
  end
end
