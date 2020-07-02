module Feriados
  class Loader
    include Rules

    def initialize(rules, calendar)
      @rules = rules
      @calendar = calendar
    end

    def load
      rules.each do |rule|
        calendar.add(Rules.create_with(rule))
      end
    end

    private

    attr_reader :rules, :calendar
  end
end
