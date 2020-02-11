require 'test_helper'

class FixDateTest < Minitest::Test
  include Feriados::Rules
  include Feriados

  def test_a_fix_date_can_be_a_holiday
    calendar = Calendar.new

    date = Date.new(2016, 1, 1)

    calendar.add(FixDate.new(2016, 1, 1))

    assert calendar.holiday?(date)
  end

  def test_a_fix_date_can_have_a_name
    calendar = Calendar.new

    date = Date.new(2016, 1, 1)

    calendar.add(FixDate.new(2016, 1, 1, 'new year'))

    assert calendar.holiday_name(date)
  end

  def test_a_fix_date_can_be_not_a_holiday
    calendar = Calendar.new

    refute calendar.holiday?(Date.new(2016, 1, 1))
  end

  def test_a_bunch_of_dates_can_be_a_holiday
    calendar = Calendar.new

    date = Date.new(2016, 4, 29)
    another_date = Date.new(2016, 4, 30)

    calendar.add(FixDate.new(2016, 4, 29))
    calendar.add(FixDate.new(2016, 4, 30))

    assert calendar.holiday?(date)
    assert calendar.holiday?(another_date)
  end

  def test_a_fix_date_rule_can_be_deleted
    calendar = Calendar.new

    date = Date.new(2016, 5, 1)

    calendar.add(FixDate.new(date.year, date.month, date.day))

    assert calendar.holiday?(date)

    calendar.remove(FixDate.new(date.year, date.month, date.day))

    refute calendar.holiday?(date)
  end
end
