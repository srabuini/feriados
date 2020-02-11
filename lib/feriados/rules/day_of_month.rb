module Feriados
  module Rules
    class DayOfMonth < RuleBase
      def initialize(day, month)
        @day = day
        @month = month
      end

      def holiday?(date)
        day == date.day && month == date.month
      end

      protected

      attr_reader :day, :month

      def state
        [day, month]
      end
    end
  end
end
