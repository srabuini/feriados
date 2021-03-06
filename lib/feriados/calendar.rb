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
    @calendar = nil

    def holiday?
      @@calendar.holiday?(self)
    end

    def holiday_name
      @@calendar.holiday_name(self)
    end
  end

  refine Date.singleton_class do
    def calendar=(calendar)
      @@calendar = calendar
    end
  end
end
