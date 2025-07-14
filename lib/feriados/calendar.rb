require 'set'
require 'date'

module Feriados
  class Calendar
    def initialize
      @rules = Set.new
    end

    def holiday?(date)
      rules.any? { |rule| rule.holiday?(date) }
    end

    def holiday_name(date)
      rules.find { |rule| rule.holiday?(date) }&.name
    end

    def add(rule)
      rules << rule
    end

    def remove(rule)
      rules.delete(rule)
    end

    def load(rules)
      Loader.new(rules, self).load
    end

    def holidays_in_year(year)
      start_date = Date.new(year, 1, 1)
      end_date = Date.new(year, 12, 31)
      holidays_between(start_date, end_date)
    end

    def holidays_between(start_date, end_date)
      holidays = []
      current_date = start_date

      while current_date <= end_date
        if holiday?(current_date)
          holidays << {
            date: current_date,
            name: holiday_name(current_date)
          }
        end
        current_date += 1
      end

      holidays
    end

    def next_holiday(from_date = Date.today)
      # Search in the next 2 years to ensure finding at least one holiday
      end_search_date = Date.new(from_date.year + 2, 12, 31)
      current_date = from_date

      while current_date <= end_search_date
        if holiday?(current_date)
          return {
            date: current_date,
            name: holiday_name(current_date)
          }
        end
        current_date += 1
      end

      nil # No holidays found in the range
    end

    def eql?(other)
      rules == other.rules
    end

    def ==(other)
      eql?(other)
    end

    protected

    attr_accessor :rules
  end

  refine Date do
    def holiday?
      calendar = Date.class_variable_get(:@@calendar) if Date.class_variable_defined?(:@@calendar)
      return false unless calendar
      calendar.holiday?(self)
    end

    def holiday_name
      calendar = Date.class_variable_get(:@@calendar) if Date.class_variable_defined?(:@@calendar)
      return nil unless calendar
      calendar.holiday_name(self)
    end
  end

  refine Date.singleton_class do
    def calendar=(calendar)
      class_variable_set(:@@calendar, calendar)
    end

    def calendar
      class_variable_get(:@@calendar) if class_variable_defined?(:@@calendar)
    end
  end
end
