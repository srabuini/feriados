require 'test_helper'

class HolyFridayTest < Minitest::Test
  include Feriados::Rules
  include Feriados

  def test_holy_friday
    calendar = Calendar.new

    date = Date.new(2016, 3, 25)

    calendar.add(HolyFriday)

    assert calendar.holiday?(date)
  end

  def test_holy_friday_has_name
    calendar = Calendar.new

    date = Date.new(2016, 3, 25)

    calendar.add(HolyFriday)

    HolyFriday.name = 'viernes santo'

    assert_equal 'viernes santo', calendar.holiday_name(date)
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
end
