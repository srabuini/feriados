require 'test_helper'

class CalendarTest < Minitest::Test
  include Feriados::Rules
  include Feriados

  def test_a_day_of_week_can_be_a_holiday
    calendar = Calendar.new

    a_saturday = Date.new(2016, 4, 30)

    calendar.add(DayOfWeek.new(a_saturday.wday))

    assert calendar.holiday?(a_saturday)
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

  def test_a_date_of_month_can_be_a_holiday
    calendar = Calendar.new

    a_january_first = Date.new(2016, 1, 1)

    calendar.add(DayOfMonth.new(1, 1))

    assert calendar.holiday?(a_january_first)
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

  def test_a_date_can_be_a_holiday
    calendar = Calendar.new

    date = Date.new(2016, 1, 1)

    calendar.add(FixDate.new(2016, 1, 1))

    assert calendar.holiday?(date)
  end

  def test_a_date_can_be_not_a_holiday
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

  def test_a_date_rule_can_be_deleted
    calendar = Calendar.new

    date = Date.new(2016, 5, 1)

    calendar.add(FixDate.new(date.year, date.month, date.day))

    assert calendar.holiday?(date)

    calendar.remove(FixDate.new(date.year, date.month, date.day))

    refute calendar.holiday?(date)
  end

  def test_easter
    calendar = Calendar.new

    date = Date.new(2016, 3, 27)

    calendar.add(Easter)

    assert calendar.holiday?(date)
  end

  def test_not_easter
    calendar = Calendar.new

    date = Date.new(2016, 3, 26)

    calendar.add(Easter)

    refute calendar.holiday?(date)
  end

  def test_remove_easter
    calendar = Calendar.new

    date = Date.new(2016, 3, 27)

    calendar.add(Easter)

    assert calendar.holiday?(date)

    calendar.remove(Easter)

    refute calendar.holiday?(date)
  end

  def test_holy_friday
    calendar = Calendar.new

    date = Date.new(2016, 3, 25)

    calendar.add(HolyFriday)

    assert calendar.holiday?(date)
  end

  def test_not_holy_friday
    calendar = Calendar.new

    date = Date.new(2016, 3, 20)

    calendar.add(HolyFriday)

    refute calendar.holiday?(date)
  end

  def test_remove_holy_friday
    calendar = Calendar.new

    date = Date.new(2016, 3, 25)

    calendar.add(HolyFriday)

    assert calendar.holiday?(date)

    calendar.remove(HolyFriday)

    refute calendar.holiday?(date)
  end

  def test_holy_thursday
    calendar = Calendar.new

    date = Date.new(2016, 3, 24)

    calendar.add(HolyThursday)

    assert calendar.holiday?(date)
  end

  def test_fix_week_day_rule
    calendar = Calendar.new

    calendar.add(FixWeekDay.new(4, 1, 11))
    calendar.add(FixWeekDay.new(3, 1, 8))

    assert calendar.holiday?(Date.new(2016, 11, 28))
    assert calendar.holiday?(Date.new(2016, 8, 15))
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

  def test_load_argentinian_holidays
    calendar = Calendar.new

    Feriados::Argentina.rules.each { |rule| calendar.add rule }

    assert calendar.holiday?(Date.new(2016, 1, 1))

    assert calendar.holiday?(Date.new(2016, 2, 8))
    assert calendar.holiday?(Date.new(2016, 2, 9))

    assert calendar.holiday?(Date.new(2016, 3, 24))
    assert calendar.holiday?(Date.new(2016, 3, 25))
    assert calendar.holiday?(Date.new(2016, 3, 27))

    assert calendar.holiday?(Date.new(2016, 4, 2))

    assert calendar.holiday?(Date.new(2016, 5, 1))
    assert calendar.holiday?(Date.new(2016, 5, 25))

    assert calendar.holiday?(Date.new(2016, 6, 20))

    assert calendar.holiday?(Date.new(2016, 7, 8))
    assert calendar.holiday?(Date.new(2016, 7, 9))

    assert calendar.holiday?(Date.new(2016, 8, 15))

    assert calendar.holiday?(Date.new(2016, 10, 10))

    assert calendar.holiday?(Date.new(2016, 11, 28))

    assert calendar.holiday?(Date.new(2016, 12, 8))
    assert calendar.holiday?(Date.new(2016, 12, 25))
  end
end
