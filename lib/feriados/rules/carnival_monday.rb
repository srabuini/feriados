module Feriados
  module Rules
    class CarnivalMonday < Function
      def self.holiday?(date)
        Easter.new(date.year).date - 48 == date
      end
    end
  end
end
