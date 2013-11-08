#encoding:utf-8

require 'helper.rb'

class DateTests < Test::Unit::TestCase
  def setup
    @date = Date.civil(2012,1,1)
  end

  def test_extending_date_class
    assert @date.respond_to?('es_feriado?')
    assert @date.respond_to?('es_fin_de_semana?')
  end

  def test_fin_de_semana
    normales = [ :lunes, :martes, :miercoles, :jueves, :viernes ]
    fin_de_semana = [ :sabado, :domingo ]
    enesimos = [ :primer, :segundo, :tercer, :cuarto ]

    (2012..2015).each do |anio|
      (1..12).each do |mes|
        enesimos.each do |n|
          normales.each do |dia|
            assert !Feriados.calculado(n, dia, mes, anio).es_fin_de_semana?
          end
          fin_de_semana.each do |dia|
            assert Feriados.calculado(n, dia, mes, anio).es_fin_de_semana?
          end
        end
      end
    end
  end

  def test_calculados
    # Día de la bandera.
    assert_equal 18, Feriados.calculado(:tercer, :lunes, 6, 2012).day
    assert_equal 17, Feriados.calculado(:tercer, :lunes, 6, 2013).day
    assert_equal 16, Feriados.calculado(:tercer, :lunes, 6, 2014).day
    assert_equal 15, Feriados.calculado(:tercer, :lunes, 6, 2015).day

    # Diecisiete de Agosto.
    assert_equal 20, Feriados.calculado(:tercer, :lunes, 8, 2012).day
    assert_equal 19, Feriados.calculado(:tercer, :lunes, 8, 2013).day
    assert_equal 18, Feriados.calculado(:tercer, :lunes, 8, 2014).day
    assert_equal 17, Feriados.calculado(:tercer, :lunes, 8, 2015).day

    # Día de la raza.
    assert_equal 15, Feriados.dia_de_la_raza(Date.civil(2012,10,12)).day
    assert_equal 12, Feriados.dia_de_la_raza(Date.civil(2013,10,12)).day
    assert_equal 12, Feriados.dia_de_la_raza(Date.civil(2014,10,12)).day
    assert_equal 12, Feriados.dia_de_la_raza(Date.civil(2015,10,12)).day

    # Pascua.
    assert_equal 8, Feriados.pascua(2012).day
    assert_equal 31, Feriados.pascua(2013).day
    assert_equal 20, Feriados.pascua(2014).day
    assert_equal 5, Feriados.pascua(2015).day 

    # Carnaval
    assert_equal 11, (Feriados.pascua(2013) - 48).day
    assert_equal 3, (Feriados.pascua(2014) - 48).day
    assert_equal 16, (Feriados.pascua(2015) - 48).day

    assert_equal 12, (Feriados.pascua(2013) - 47).day
    assert_equal 4, (Feriados.pascua(2014) - 47).day
    assert_equal 17, (Feriados.pascua(2015) - 47).day
  end

  def test_feriados_fijos
    2012.upto(2015) do |anio|
      assert Date.civil(anio, 1,  1).es_feriado?
      assert Date.civil(anio, 3,  24).es_feriado?
      assert Date.civil(anio, 4,  2).es_feriado?
      assert Date.civil(anio, 5,  1).es_feriado?
      assert Date.civil(anio, 7,  9).es_feriado?
      assert Date.civil(anio, 12, 8).es_feriado?
      assert Date.civil(anio, 12, 25).es_feriado?      
    end
  end
end