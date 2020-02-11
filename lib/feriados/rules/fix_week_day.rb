module Feriados
  module Rules
    class FixWeekDay < RuleBase
      def initialize(week, wday, month, name = nil)
        super(name)
        @week = week
        @wday = wday
        @month = month
      end

      def holiday?(date)
        date_from_week = (date.day - 1) / 7 + 1
        wday == date.wday && month == date.month && week == date_from_week
      end

      protected

      attr_reader :week, :wday, :month

      def state
        [week, wday, month]
      end
    end
  end
end
