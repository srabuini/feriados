module Feriados
  module Argentina
    include Feriados::Rules

    def self.rules
      [
        DayOfMonth.new(1, 1),
        DayOfMonth.new(24, 3),
        DayOfMonth.new(2, 4),
        DayOfMonth.new(1, 5),
        DayOfMonth.new(25, 5),
        DayOfMonth.new(20, 6),
        DayOfMonth.new(9, 7),
        DayOfMonth.new(8, 12),
        DayOfMonth.new(25, 12),

        Easter,
        HolyThursday,
        HolyFriday,
        CarnivalMonday,
        CarnivalTuesday,

        FixWeekDay.new(3, 1, 8),
        FixWeekDay.new(2, 1, 10),
        FixWeekDay.new(4, 1, 11),

        FixDate.new(2012, 2, 27),
        FixDate.new(2012, 9, 24),
        FixDate.new(2012, 4, 30),
        FixDate.new(2012, 12, 24),

        FixDate.new(2013, 1, 31),
        FixDate.new(2013, 2, 20),
        FixDate.new(2013, 1, 31),
        FixDate.new(2013, 4, 1),
        FixDate.new(2013, 6, 21),

        FixDate.new(2014, 5, 2),
        FixDate.new(2014, 12, 26),

        FixDate.new(2015, 3, 23),
        FixDate.new(2015, 12, 7),

        FixDate.new(2016, 7, 8),
        FixDate.new(2016, 12, 9)
      ]
    end
  end
end
