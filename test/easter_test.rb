require 'test_helper'

class EasterTest < Minitest::Test
  include Feriados::Rules
  include Feriados

  def test_easter
    calendar = Calendar.new

    date = Date.new(2016, 3, 27)

    calendar.add(Easter)

    assert calendar.holiday?(date)
  end

  def test_easter_can_have_name
    calendar = Calendar.new

    date = Date.new(2016, 3, 27)

    Easter.name = 'pascua'

    calendar.add(Easter)

    assert_equal 'pascua', calendar.holiday_name(date)
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
end
