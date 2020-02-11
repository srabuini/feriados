require 'test_helper'

class DayOfMonthTest < Minitest::Test
  include Feriados::Rules
  include Feriados

  def test_a_date_of_month_can_be_a_holiday
    calendar = Calendar.new

    a_january_first = Date.new(2016, 1, 1)

    calendar.add(DayOfMonth.new(1, 1))

    assert calendar.holiday?(a_january_first)
  end

  def test_a_date_of_month_can_have_a_name
    calendar = Calendar.new

    a_january_first = Date.new(2016, 1, 1)

    calendar.add(DayOfMonth.new(1, 1, 'new year'))

    assert_equal 'new year', calendar.holiday_name(a_january_first)
  end

  def test_a_day_of_month_can_be_not_a_holiday
    calendar = Calendar.new

    a_day = Date.new(2016, 1, 2)

    calendar.add(DayOfMonth.new(1, 1))

    refute calendar.holiday?(a_day)
  end

  def test_a_bunch_of_days_of_month_can_be_a_holiday
    calendar = Calendar.new

    a_christmas = Date.new(2016, 12, 25)
    a_january_first = Date.new(2016, 1, 1)

    calendar.add(DayOfMonth.new(1, 1))
    calendar.add(DayOfMonth.new(25, 12))

    assert calendar.holiday?(a_christmas)
    assert calendar.holiday?(a_january_first)
  end

  def test_a_day_of_month_rule_can_be_deleted
    calendar = Calendar.new

    date = Date.new(2016, 5, 1)

    calendar.add(DayOfMonth.new(date.day, date.month))

    assert calendar.holiday?(date)

    calendar.remove(DayOfMonth.new(date.day, date.month))

    refute calendar.holiday?(date)
  end
end
