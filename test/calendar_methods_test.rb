require 'test_helper'

class CalendarMethodsTest < Minitest::Test
  def setup
    @calendar = Feriados::Calendar.new

    # Add some test holidays
    @calendar.add Feriados::Rules::DayOfMonth.new(1, 1, 'Año Nuevo')
    @calendar.add Feriados::Rules::DayOfMonth.new(25, 12, 'Navidad')
    @calendar.add Feriados::Rules::DayOfMonth.new(14, 2, 'San Valentín')
    @calendar.add Feriados::Rules::FixDate.new(2025, 7, 4, 'Día Especial 2025')
  end

  def test_holidays_in_year
    holidays_2025 = @calendar.holidays_in_year(2025)

    assert_equal 4, holidays_2025.length

    # Verify they are sorted chronologically
    dates = holidays_2025.map { |h| h[:date] }
    assert_equal dates.sort, dates

    # Verify specific dates
    new_year = holidays_2025.find { |h| h[:date].month == 1 && h[:date].day == 1 }
    assert_equal 'Año Nuevo', new_year[:name]

    christmas = holidays_2025.find { |h| h[:date].month == 12 && h[:date].day == 25 }
    assert_equal 'Navidad', christmas[:name]
  end

  def test_holidays_between
    start_date = Date.new(2025, 1, 1)
    end_date = Date.new(2025, 2, 28)

    holidays = @calendar.holidays_between(start_date, end_date)

    assert_equal 2, holidays.length
    assert holidays.any? { |h| h[:name] == 'Año Nuevo' }
    assert holidays.any? { |h| h[:name] == 'San Valentín' }
  end

  def test_next_holiday
    # Search for next holiday from January 10, 2025
    from_date = Date.new(2025, 1, 10)
    next_holiday = @calendar.next_holiday(from_date)

    assert_equal Date.new(2025, 2, 14), next_holiday[:date]
    assert_equal 'San Valentín', next_holiday[:name]
  end

  def test_next_holiday_when_from_date_is_holiday
    # If the start date is a holiday, it should return that same day
    from_date = Date.new(2025, 1, 1)
    next_holiday = @calendar.next_holiday(from_date)

    assert_equal Date.new(2025, 1, 1), next_holiday[:date]
    assert_equal 'Año Nuevo', next_holiday[:name]
  end

  def test_next_holiday_returns_nil_when_no_holidays
    empty_calendar = Feriados::Calendar.new

    next_holiday = empty_calendar.next_holiday(Date.new(2025, 1, 1))

    assert_nil next_holiday
  end

  def test_holidays_in_year_with_no_holidays
    holidays_2024 = @calendar.holidays_in_year(2024)

    # Only fixed holidays should appear (without the 2025 FixDate)
    assert_equal 3, holidays_2024.length
    refute holidays_2024.any? { |h| h[:name] == 'Día Especial 2025' }
  end
end
