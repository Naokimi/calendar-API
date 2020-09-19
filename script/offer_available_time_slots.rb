slots = Scheduler.new.call

puts 'Hey guys, for this week these are my available time slots:'
slots.each { |slot| puts '- ' + slot.strftime('%^a %d/%m %H:%M') }
puts 'As always, feel free to message me to book one of them for pair programming, discussion, or anything else.'
