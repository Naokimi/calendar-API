class Scheduler
  Time.zone = 'Japan'

  def initialize
    @slots = []
    @booked_slots = []
  end

  def call
    prepare_slots
    check_booked_slots
    return_free_slots
  end

  private

  def prepare_slots
    day = 0
    weekday_hours = [12, 13, 14, 22, 23]
    weekend_hours = [22, 23]
    until day >= 7
      date = Date.today.in_time_zone.beginning_of_day + day.days
      hours = day >= 5 ? weekend_hours : weekday_hours
      hours.each { |hour| @slots << date + hour.hours }
      day += 1
    end
  end

  def check_booked_slots
    next_week_events = CalendarReader.new.next_week_events.map { |event| event.dtstart.to_i..event.dtend.to_i }
    next_week_events.each do |event|
      event.step(15.minutes) { |time| @booked_slots << Time.at(time) if (time % 1.hour).zero? }
    end
    @booked_slots.uniq!
  end

  def return_free_slots
    @slots.reject do |slot|
      @booked_slots.include?(slot)
    end
  end
end
