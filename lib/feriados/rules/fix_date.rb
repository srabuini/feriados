module Feriados
  module Rules
    class FixDate < RuleBase
      def initialize(year, month, day, name = nil)
        super(name)
        @year = year
        @month = month
        @day = day
      end

      def holiday?(date)
        year == date.year && month == date.month && day == date.day
      end

      protected

      attr_reader :day, :month, :year

      def state
        [year, month, day]
      end
    end
  end
end
