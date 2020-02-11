require 'test_helper'

class FixWeekDayTest < Minitest::Test
  include Feriados::Rules
  include Feriados

  def test_fix_week_day_rule
    calendar = Calendar.new

    calendar.add(FixWeekDay.new(4, 1, 11))
    calendar.add(FixWeekDay.new(3, 1, 8))

    assert calendar.holiday?(Date.new(2016, 11, 28))
    assert calendar.holiday?(Date.new(2016, 8, 15))
  end

  def test_fix_week_can_have_a_name
    calendar = Calendar.new

    calendar.add(FixWeekDay.new(3, 1, 8, 'nice holiday'))

    assert_equal 'nice holiday', calendar.holiday_name(Date.new(2016, 8, 15))
  end

  def test_not_fix_week_day_rule
    calendar = Calendar.new

    date = Date.new(2016, 5, 2)

    calendar.add(FixWeekDay.new(2, 1, 5))

    refute calendar.holiday?(date)
  end

  def test_remove_fix_week_day_rule
    calendar = Calendar.new

    date = Date.new(2016, 11, 28)

    calendar.add(FixWeekDay.new(4, 1, 11))

    assert calendar.holiday?(date)

    calendar.remove(FixWeekDay.new(4, 1, 11))

    refute calendar.holiday?(date)
  end
end
