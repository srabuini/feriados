require 'date'

module Feriados
  DAYS = {sunday: 7, monday: 1, tuesday: 2, wednesday: 3, thursday: 4,
    friday: 5, saturday: 6}

  def self.add(description, options = {})
    @holidays_by_month ||= {}
    month = options[:month] || 0
    @holidays_by_month[month] ||= []
    @holidays_by_month[month] << {description: description}.merge!(options)
  end

  def self.calculated(th, day, month, year)
    n = {first: 1, second: 2, third: 3, fourth: 4}

    week = n[th]
    date = Date.civil(year, month, 1)
    offset = DAYS[day] - date.wday
    offset += 7 if offset < 0
    offset += 7 * (week - 1)
    date + offset
  end

  def self.easter(year)
    y = year
    a = y % 19
    b = y / 100
    c = y % 100
    d = b / 4
    e = b % 4
    f = (b + 8) / 25
    g = (b - f + 1) / 3
    h = (19 * a + b - d - g + 15) % 30
    i = c / 4
    k = c % 4
    l = (32 + 2 * e + 2 * i - h - k) % 7
    m = (a + 11 * h + 22 * l) / 451
    month = (h + l - 7 * m + 114) / 31
    day = ((h + l - 7 * m + 114) % 31) + 1
    Date.civil(year, month, day)
  end

  def self.between(start_date, end_date)
    dates, list = {}, []

    (start_date..end_date).each do |date|
      dates[date.year] = [0] unless dates[date.year]
      unless dates[date.year].include?(date.month)
        dates[date.year] << date.month
      end
    end

    dates.each do |year, months|
      months.each do |month|
        if holidays = @holidays_by_month[month]
          holidays.each do |holiday|
            description = holiday[:description]

            date = if holiday[:function]
              holiday[:function].call(year)
            elsif holiday[:fix_change]
              calculated(holiday[:fix_change][0], holiday[:fix_change][1],
                month, year)
            elsif holiday[:variable_change]
              holiday[:variable_change].call(Date.civil(year, month,
                holiday[:day]))
            else
              Date.civil(holiday[:year] || year, month, holiday[:day])
            end

            if date.between?(start_date, end_date) && date.year == year
              list << { date: date, description: description }
            end
          end
        end
      end
    end

    list.sort_by { |holidays| holidays[:date] }
  end
end

class Date
  def is_holiday?
    holidays = Feriados.between(self, self)
    holidays && !holidays.empty?
  end

  def is_week_end?
    self.wday == 6 or self.wday == 0
  end
end
