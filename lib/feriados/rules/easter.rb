module Feriados
  module Rules
    class Easter
      def initialize(year)
        @year = year
      end

      def date
        a = year % 19
        b = year / 100
        c = year % 100
        d = b / 4
        e = b % 4
        f = (b + 8) / 25
        g = (b - f + 1) / 3
        h = (19 * a + b - d - g + 15) % 30
        i = c / 4
        k = c % 4
        l = (32 + 2 * e + 2 * i - h - k) % 7
        m = (a + 11 * h + 22 * l) / 451
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

      attr_reader :year
    end
  end
end
