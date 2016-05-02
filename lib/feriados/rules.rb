module Feriados
  module Rules
    class RuleBase
      def hash
        state.hash
      end

      def eql?(other)
        hash == other.hash
      end

      def ==(other)
        eql?(other)
      end
    end

    class DayOfWeek < RuleBase
      def initialize(wday)
        @wday = wday
      end

      def holiday?(date)
        @wday == date.wday
      end

      protected

      def state
        [@wday]
      end
    end

    class DayOfMonth < RuleBase
      def initialize(day, month)
        @day = day
        @month = month
      end

      def holiday?(date)
        @day == date.day && @month == date.month
      end

      protected

      def state
        [@day, @month]
      end
    end

    class FixDate < RuleBase
      def initialize(year, month, day)
        @year = year
        @month = month
        @day = day
      end

      def holiday?(date)
        @year == date.year && @month == date.month && @day = date.day
      end

      protected

      def state
        [@year, @month, @day]
      end
    end

    class Easter
      def initialize(year)
        @year = year
      end

      def date
        a = @year % 19
        b = @year / 100
        c = @year % 100
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

        Date.new(@year, month, day)
      end

      def self.holiday?(date)
        easter = Easter.new(date.year)

        easter.date == date
      end
    end

    class HolyFriday
      def self.holiday?(date)
        Easter.new(date.year).date - 2 == date
      end
    end

    class HolyThursday
      def self.holiday?(date)
        Easter.new(date.year).date - 3 == date
      end
    end

    class CarnivalMonday
      def self.holiday?(date)
        Easter.new(date.year).date - 48 == date
      end
    end

    class CarnivalTuesday
      def self.holiday?(date)
        Easter.new(date.year).date - 47 == date
      end
    end

    class FixWeekDay < RuleBase
      def initialize(week, wday, month)
        @week = week
        @wday = wday
        @month = month
      end

      def holiday?(date)
        week = (date.day - 1) / 7 + 1
        @wday == date.wday && @month == date.month && @week == week
      end

      protected

      def state
        [@week, @wday, @month]
      end
    end
  end
end
