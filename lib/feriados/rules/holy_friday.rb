module Feriados
  module Rules
    class HolyFriday
      def self.holiday?(date)
        Easter.new(date.year).date - 2 == date
      end
    end
  end
end
