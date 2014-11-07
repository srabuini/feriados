#encoding: utf-8

module Feriados
  module Argentina
    # Feriados Fijos
    Feriados.add 'Año nuevo', day: 1, month: 1
    Feriados.add 'Día Nacional de la Memoria por la Verdad y la Justicia',
     day: 24, month: 3
    Feriados.add 'Día del Veterano y de los Caídos en la Guerra de Malvinas',
     day: 2, month: 4
    Feriados.add 'Día del trabajador', day: 1, month: 5
    Feriados.add 'Día de la Revolución de Mayo', day: 25, month: 5
    Feriados.add 'Paso a la Inmortalidad del General Manuel Belgrano', day: 20,
     month: 6
    Feriados.add 'Día de la Independencia', day: 9, month: 7
    Feriados.add 'Inmaculada Concepción de María', day: 8, month: 12
    Feriados.add 'Navidad', day: 25, month: 12

    # Feriados calculados
    Feriados.add 'easter', function: ->(year) { Feriados.easter(year) }
    Feriados.add 'Viernes Santo', function: ->(year) { Feriados.easter(year) - 2 }
    Feriados.add 'Jueves Santo', function: ->(year) { Feriados.easter(year) - 3 }
    Feriados.add 'Lunes de Carnaval', function: ->(year) { Feriados.easter(year) - 48 }
    Feriados.add 'Martes de Carnaval', function: ->(year) { Feriados.easter(year) - 47 }

    # Feriados relativos
    Feriados.add 'Paso a la Inmortalidad del General José de San Martín',
     day: 17, month: 8, fix_change: [:third, :monday]
    Feriados.add 'Día del Respeto a la Diversidad Cultural', day: 12, month: 10,
     fix_change: [:second, :monday]
    Feriados.add 'Día de la Soberanía Nacional', day: 20, month: 11,
     fix_change: [:fourth, :monday]

    # Feriados especiales 2012
    Feriados.add "Día del Bicentenario de la Creación y Primera Jura de la \
      Bandera Argentina", day: 27, month: 2, year: 2012
    Feriados.add "Día del Bicentenario de la Batalla de Tucumán", day: 24,
     month: 9, year: 2012
    Feriados.add "Feriado puente", day: 30, month: 4, year: 2012
    Feriados.add "Feriado puente", day: 24, month: 12, year: 2012

    # Feriados especiales 2013
    Feriados.add "Bicentenario de la Asamblea General Constituyente de 1813",
     day: 31, month: 1, year: 2013
    Feriados.add "Día de la Batalla de Salta", day: 20, month: 2, year: 2013
    Feriados.add "Feriado puente", day: 1, month: 4, year: 2013
    Feriados.add "Feriado puente", day: 21, month: 6, year: 2013

    # Feriados especiales 2014
    Feriados.add "Feriado puente", day: 2, month: 5, year: 2014
    Feriados.add "Feriado puente", day: 26, month: 12, year: 2014

    # Feriados especiales 2015
    Feriados.add "Feriado puente", day: 23, month: 3, year: 2015
    Feriados.add "Feriado puente", day: 7, month: 12, year: 2015

    # Feriados especiales 2016
    Feriados.add "Feriado puente", day: 8, month: 7, year: 2016
    Feriados.add "Feriado puente", day: 9, month: 12, year: 2016
  end
end
