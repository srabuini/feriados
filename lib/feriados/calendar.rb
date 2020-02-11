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

    def add(rule)
      rules << rule
    end

    def remove(rule)
      rules.delete(rule)
    end

    def push(rules)
      self.rules = rules
    end

    def load_rules(file)
      Loader.new(file, self).load
    end

    private

    attr_accessor :rules
  end

  refine Date do
    def holiday?
      @@calendar.holiday?(self)
    end
  end

  refine Date.singleton_class do
    def calendar=(calendar)
      @@calendar = calendar
    end
  end
end
