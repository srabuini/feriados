#encoding:utf-8

require 'helper.rb'

class DateTests < MiniTest::Test
  def setup
    @date = Date.civil(2012,1,1)
  end

  def test_extending_date_class
    assert @date.respond_to?('is_holiday?')
    assert @date.respond_to?('is_week_end?')
  end

  def test_week_end
    regulars = [ :monday, :tuesday, :wednesday, :thursday, :friday ]
    week_end = [ :saturday, :sunday ]
    nths = [ :first, :second, :third, :fourth ]

    (2012..2015).each do |year|
      (1..12).each do |month|
        nths.each do |n|
          regulars.each do |day|
            assert !Feriados.calculated(n, day, month, year).is_week_end?
          end
          week_end.each do |day|
            assert Feriados.calculated(n, day, month, year).is_week_end?
          end
        end
      end
    end
  end

  def test_calculated
    # Día de la bandera.
    assert_equal 18, Feriados.calculated(:third, :monday, 6, 2012).day
    assert_equal 17, Feriados.calculated(:third, :monday, 6, 2013).day
    assert_equal 16, Feriados.calculated(:third, :monday, 6, 2014).day
    assert_equal 15, Feriados.calculated(:third, :monday, 6, 2015).day

    # Diecisiete de Agosto.
    assert_equal 20, Feriados.calculated(:third, :monday, 8, 2012).day
    assert_equal 19, Feriados.calculated(:third, :monday, 8, 2013).day
    assert_equal 18, Feriados.calculated(:third, :monday, 8, 2014).day
    assert_equal 17, Feriados.calculated(:third, :monday, 8, 2015).day

    # Easter.
    assert_equal 8, Feriados.easter(2012).day
    assert_equal 31, Feriados.easter(2013).day
    assert_equal 20, Feriados.easter(2014).day
    assert_equal 5, Feriados.easter(2015).day

    # Carnaval
    assert_equal 11, (Feriados.easter(2013) - 48).day
    assert_equal 3, (Feriados.easter(2014) - 48).day
    assert_equal 16, (Feriados.easter(2015) - 48).day

    assert_equal 12, (Feriados.easter(2013) - 47).day
    assert_equal 4, (Feriados.easter(2014) - 47).day
    assert_equal 17, (Feriados.easter(2015) - 47).day
  end

  def test_fix_holidays
    2012.upto(2015) do |year|
      assert Date.civil(year, 1,  1).is_holiday?
      assert Date.civil(year, 3,  24).is_holiday?
      assert Date.civil(year, 4,  2).is_holiday?
      assert Date.civil(year, 5,  1).is_holiday?
      assert Date.civil(year, 7,  9).is_holiday?
      assert Date.civil(year, 12, 8).is_holiday?
      assert Date.civil(year, 12, 25).is_holiday?
    end
  end
end
