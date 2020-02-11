module Feriados
  module Rules
    class DayOfWeek < RuleBase
      def initialize(wday)
        @wday = wday
      end

      def holiday?(date)
        wday == date.wday
      end

      protected
      attr_reader :wday

      def state
        [wday]
      end
    end
  end
end
