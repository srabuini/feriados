module Feriados
  module Rules
    class Easter < Function
      @name = nil

      def initialize(year)
        @year = year
      end

      def date
        result = h + l - 7 * m + 114

        month = result / 31
        day = (result % 31) + 1

        Date.new(year, month, day)
      end

      def self.holiday?(date)
        easter = Easter.new(date.year)

        easter.date == date
      end

      private

      def a
        year % 19
      end

      def b
        year / 100
      end

      def c
        year % 100
      end

      def d
        b / 4
      end

      def e
        b % 4
      end

      def f
        (b + 8) / 25
      end

      def g
        (b - f + 1) / 3
      end

      def h
        (19 * a + b - d - g + 15) % 30
      end

      def i
        c / 4
      end

      def k
        c % 4
      end

      def l
        (32 + 2 * e + 2 * i - h - k) % 7
      end

      def m
        (a + 11 * h + 22 * l) / 451
      end

      attr_reader :year
    end
  end
end
