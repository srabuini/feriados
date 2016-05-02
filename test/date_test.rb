require 'test_helper'

class DateTest < Minitest::Test
  include Feriados::Rules
  include Feriados
  using Feriados

  def test_using_refinements
    calendar = Calendar.new
    Date.calendar = calendar

    date = Date.new(2016, 5, 2)

    calendar.add(FixDate.new(date.year, date.month, date.day))

    assert calendar.holiday?(date)

    assert date.holiday?
  end
end
