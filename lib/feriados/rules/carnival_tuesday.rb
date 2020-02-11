module Feriados
  module Rules
    class CarnivalTuesday < Function
      def self.holiday?(date)
        Easter.new(date.year).date - 47 == date
      end
    end
  end
end
