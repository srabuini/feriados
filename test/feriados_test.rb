require 'test_helper'
require 'yaml'

class CalendarTest < Minitest::Test
  include Feriados::Rules
  include Feriados

  YEAR = 2023

  def test_load_argentinian_holidays
    calendar = Calendar.new

    file = File.join(__dir__, './argentina.yml')
    rules = YAML.load_file(file)

    calendar.load(rules)

    holidays2023_data = [
      [1, 1, 'Año nuevo'],
      [2, 20, 'Lunes de carnaval'],
      [2, 21, 'Martes de carnaval'],
      [3, 24, 'Día Nacional de la Memoria por la Verdad y la Justicia'],
      [4, 2, 'Día del Veterano y de los Caídos en la Guerra de Malvinas'],
      [4, 6, 'Jueves Santo'],
      [4, 7, 'Viernes Santo'],
      [4, 9, 'Pascua'],
      [5, 1, 'Día del Trabajador'],
      [5, 25, 'Día de la Revolución de Mayo'],
      [5, 26, 'Feriado con fines turísticos'],
      [6, 19, 'Paso a la Inmortalidad del Gral. Don Martín Miguel de Güemes'],
      [6, 20, 'Paso a la Inmortalidad del Gral. Manuel Belgrano'],
      [7, 9, 'Día de la Independencia'],
      [8, 21, 'Paso a la Inmortalidad del Gral. José de San Martín'],
      [10, 13, 'Feriado con fines turísticos'],
      [10, 16, 'Día del Respeto a la Diversidad Cultural'],
      [11, 20, 'Día de la Soberanía Nacional'],
      [12, 8, 'Inmaculada Concepción de María'],
      [12, 25, 'Navidad']
    ]

    holidays2023_data.each do |month, day, description|
      date = Date.new(YEAR, month, day)

      assert calendar.holiday?(date), date

      assert_equal description, calendar.holiday_name(date), date
    end

    detected_holidays = 0
    first_day = Date.new(YEAR, 1, 1)
    last_day = Date.new(YEAR, 12, 31)

    first_day.upto(last_day) do |day|
      detected_holidays += 1 if calendar.holiday?(day)
    end

    assert_equal holidays2023_data.count, detected_holidays
  end

  def test_load_incomplete_rules
    rules = {}

    calendar = Calendar.new

    calendar.load(rules)

    assert_equal calendar, Calendar.new
  end
end
