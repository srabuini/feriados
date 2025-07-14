#!/usr/bin/env ruby

require_relative '../lib/feriados'

# Create a calendar with Argentine holidays
calendar = Feriados::Calendar.new

# Load holidays from YAML file
require 'yaml'
rules = YAML.load_file('test/argentina.yml')
calendar.load(rules)

puts "=== Usage examples of new Calendar methods ==="
puts

# 1. Get all holidays for 2025
puts "🗓️  Holidays in 2025:"
holidays_2025 = calendar.holidays_in_year(2025)
holidays_2025.each do |holiday|
  puts "   #{holiday[:date].strftime('%d/%m/%Y')} - #{holiday[:name]}"
end
puts "   Total: #{holidays_2025.length} holidays"
puts

# 2. Get holidays in a specific range
puts "📅 Holidays between March and May 2025:"
start_date = Date.new(2025, 3, 1)
end_date = Date.new(2025, 5, 31)
holidays_range = calendar.holidays_between(start_date, end_date)
holidays_range.each do |holiday|
  puts "   #{holiday[:date].strftime('%d/%m/%Y')} - #{holiday[:name]}"
end
puts

# 3. Find the next holiday
puts "🔜 Next holiday from today (#{Date.today.strftime('%d/%m/%Y')}):"
next_holiday = calendar.next_holiday(Date.today)
if next_holiday
  days_until = (next_holiday[:date] - Date.today).to_i
  puts "   #{next_holiday[:date].strftime('%d/%m/%Y')} - #{next_holiday[:name]}"
  puts "   (#{days_until} days remaining)"
else
  puts "   No upcoming holidays found"
end
puts

# 4. Next holiday from a specific date
specific_date = Date.new(2025, 6, 1)
puts "🔜 Next holiday from #{specific_date.strftime('%d/%m/%Y')}:"
next_from_specific = calendar.next_holiday(specific_date)
if next_from_specific
  puts "   #{next_from_specific[:date].strftime('%d/%m/%Y')} - #{next_from_specific[:name]}"
else
  puts "   No upcoming holidays found"
end
