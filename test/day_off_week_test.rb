require 'test_helper'

class DayOfWeekTest < Minitest::Test
  include Feriados::Rules
  include Feriados

  def test_a_day_of_week_can_be_a_holiday
    calendar = Calendar.new

    a_saturday = Date.new(2016, 4, 30)

    calendar.add(DayOfWeek.new(a_saturday.wday))

    assert calendar.holiday?(a_saturday)
  end

  def test_a_day_of_week_can__a_name
    calendar = Calendar.new

    a_saturday = Date.new(2016, 4, 30)

    calendar.add(DayOfWeek.new(a_saturday.wday, 'saturday night live'))

    assert_equal 'saturday night live', calendar.holiday_name(a_saturday)
  end

  def test_a_day_of_week_with_no_a_name
    calendar = Calendar.new

    a_saturday = Date.new(2016, 4, 30)

    calendar.add(DayOfWeek.new(a_saturday.wday))

    assert_nil calendar.holiday_name(a_saturday)
  end

  def test_a_day_of_week_can_be_not_a_holiday
    calendar = Calendar.new

    a_monday = Date.new(2016, 5, 2)

    refute calendar.holiday?(a_monday)
  end

  def test_a_bunch_of_days_can_be_a_holiday
    calendar = Calendar.new

    a_saturday = Date.new(2016, 4, 30)
    a_sunday = Date.new(2016, 5, 1)

    calendar.add(DayOfWeek.new(a_saturday.wday))
    calendar.add(DayOfWeek.new(a_sunday.wday))

    assert calendar.holiday?(a_sunday)
    assert calendar.holiday?(a_saturday)
  end

  def test_a_day_of_week_rule_can_be_deleted
    calendar = Calendar.new

    date = Date.new(2016, 5, 1)

    calendar.add(DayOfWeek.new(date.wday))

    assert calendar.holiday?(date)

    calendar.remove(DayOfWeek.new(date.wday))

    refute calendar.holiday?(date)
  end
end
