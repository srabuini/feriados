module Feriados
  module Brazil
    include Feriados::Rules

    def self.rules
      [
        DayOfMonth.new(1, 1),
        DayOfMonth.new(21, 4),
        DayOfMonth.new(1, 5),
        DayOfMonth.new(4, 6),
        DayOfMonth.new(7, 9),
        DayOfMonth.new(12, 10),
        DayOfMonth.new(2, 11),
        DayOfMonth.new(15, 11),
        DayOfMonth.new(25, 12),

        HolyFriday,
        CarnivalMonday,
        CarnivalTuesday
      ]
    end
  end
end
