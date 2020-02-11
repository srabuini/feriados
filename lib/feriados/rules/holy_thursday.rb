module Feriados
  module Rules
    class HolyThursday < Function
      def self.holiday?(date)
        Easter.new(date.year).date - 3 == date
      end
    end
  end
end
