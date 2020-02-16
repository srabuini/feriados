require 'test_helper'

class CalendarTest < Minitest::Test
  include Feriados::Rules
  include Feriados

  def test_load_argentinian_holidays
    calendar = Calendar.new

    file = File.join(__dir__, './argentina.yml')
    rules = YAML.load_file(file)

    calendar.load(rules)

    holidays2020_data = [
      [1, 1, 'Año nuevo'],
      [2, 24, 'Lunes de carnaval'],
      [2, 25, 'Martes de carnaval'],
      [3, 23, 'Feriado con fines turísticos'],
      [3, 24, 'Día Nacional de la Memoria por la Verdad y la Justicia'],
      [4, 2, 'Día del Veterano y de los Caídos en la Guerra de Malvinas'],
      [4, 9, 'Jueves Santo'],
      [4, 10, 'Viernes Santo'],
      [4, 12, 'Pascua'],
      [5, 1, 'Día del Trabajador'],
      [5, 25, 'Día de la Revolución de Mayo'],
      [6, 15, 'Día Paso a la Inmortalidad del General Martín Miguel de Güemes'],
      [6, 20, 'Día de la Bandera'],
      [7, 9, 'Día de la Independencia'],
      [7, 10, 'Feriado con fines turísticos'],
      [8, 17, 'Paso a la Inmortalidad del Gral. José de San Martín'],
      [10, 12, 'Día del Respeto a la Diversidad Cultural'],
      [11, 23, 'Día de la Soberanía Nacional'],
      [12, 7, 'Feriado con fines turísticos'],
      [12, 8, 'Inmaculada Concepción de María'],
      [12, 25, 'Navidad']
    ]

    holidays2020_data.each do |month, day, description|
      date = Date.new(2020, month, day)

      assert calendar.holiday?(date)

      assert_equal description, calendar.holiday_name(date), date
    end

    date = Date.new(2020, 1, 1)
    detected_holidays = []

    0.upto(365) do |day|
      detected_holidays << calendar.holiday?(date + day)
    end

    assert_equal(holidays2020_data.count, detected_holidays.count { |e| e })
  end

  def test_load_incomplete_rules
    rules = {}

    calendar = Calendar.new

    calendar.load(rules)

    assert_equal calendar, Calendar.new
  end
end
