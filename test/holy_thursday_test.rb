require 'test_helper'

class HolyThursdayTest < Minitest::Test
  include Feriados::Rules
  include Feriados

  def test_holy_thursday
    calendar = Calendar.new

    date = Date.new(2016, 3, 24)

    calendar.add(HolyThursday)

    assert calendar.holiday?(date)
  end

  def test_holy_thursday_has_name
    calendar = Calendar.new

    date = Date.new(2016, 3, 24)

    calendar.add(HolyThursday)

    HolyThursday.name = 'jueves santo'

    assert_equal 'jueves santo', calendar.holiday_name(date)
  end
end
