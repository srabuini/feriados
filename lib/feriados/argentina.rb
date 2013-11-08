#encoding: utf-8

module Feriados
  module Argentina
    # Feriados Fijos
    Feriados.add 'Año nuevo', dia:  1, mes:  1
    Feriados.add 'Día Nacional de la Memoria por la Verdad y la Justicia', dia:  24, mes:  3
    Feriados.add 'Día del Veterano y de los Caídos en la Guerra de Malvinas', dia:  2, mes:  4
    Feriados.add 'Día del trabajador', dia:  1, mes:  5
    Feriados.add 'Día de la Revolución de Mayo', dia:  25, mes:  5
    Feriados.add 'Paso a la Inmortalidad del General Manuel Belgrano', dia:  20, mes:  6
    Feriados.add 'Día de la Independencia', dia:  9, mes:  7
    Feriados.add 'Inmaculada Concepción de María', dia:  8, mes:  12
    Feriados.add 'Navidad', dia:  25, mes:  12

    # Feriados calculados
    Feriados.add 'Pascua', funcion: ->(anio) { Feriados.pascua(anio) }
    Feriados.add 'Viernes Santo', funcion: ->(anio) { Feriados.pascua(anio) - 2 }
    Feriados.add 'Jueves Santo', funcion: ->(anio) { Feriados.pascua(anio) - 3 }
    Feriados.add 'Lunes de Carnaval', funcion: ->(anio) { Feriados.pascua(anio) - 48 }
    Feriados.add 'Martes de Carnaval', funcion: ->(anio) { Feriados.pascua(anio) - 47 }

    # Feriados relativos
    Feriados.add 'Paso a la Inmortalidad del General José de San Martín', dia:  17, mes:  8, cambia_fijo:  [:tercer, :lunes]
    Feriados.add 'Día del Respeto a la Diversidad Cultural', dia:  12, mes:  10, cambia_fijo:  [:segundo, :lunes]
    Feriados.add 'Día de la Soberanía Nacional', dia:  20, mes:  11, cambia_fijo:  [:cuarto, :lunes]

    # Feriados especiales 2012
    Feriados.add "Día del Bicentenario de la Creación y Primera Jura de la Bandera Argentina", dia:  27, mes:  2, anio: 2012
    Feriados.add "Día del Bicentenario de la Batalla de Tucumán", dia:  24, mes:  9, anio: 2012
    Feriados.add "Feriado puente", dia:  30, mes:  4, anio: 2012
    Feriados.add "Feriado puente", dia:  24, mes:  12, anio: 2012

    # Feriados especiales 2013
    Feriados.add "Bicentenario de la Asamblea General Constituyente de 1813", dia: 31, mes: 1, anio: 2013
    Feriados.add "Día de la Batalla de Salta", dia: 20, mes: 2
    Feriados.add "Feriado puente", dia:  1, mes:  4, anio: 2013
    Feriados.add "Feriado puente", dia:  21, mes:  6, anio: 2013
  end
end
