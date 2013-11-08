require 'date'
require 'feriados/dsl'

module Feriados

  def self.add(descripcion, opciones={})
    @feriados_por_mes ||= {}
    nombre = { :nombre => descripcion }
    nombre.merge! opciones
    mes = opciones[:mes]
    if mes
      @feriados_por_mes[mes] ||= []
      @feriados_por_mes[mes] << nombre
    else
      @feriados_por_mes[0] ||= []
      @feriados_por_mes[0] << nombre
    end
  end

  DIA = {:domingo => 7, :lunes => 1, :martes => 2, :miercoles => 3, :jueves => 4, :viernes => 5, :sabado => 6}  

  def self.calculado(enesimo,dia,mes,anio)
    n = {:primer => 1, :segundo => 2, :tercer => 3, :cuarto => 4}

    semana = n[enesimo]
    fecha = Date.civil(anio,mes,1)
    offset = DIA[dia] - fecha.wday
    offset += 7 if offset < 0
    offset += 7 * (semana-1)
    fecha + offset
  end

  def self.pascua(year)
    y = year
    a = y % 19
    b = y / 100
    c = y % 100
    d = b / 4
    e = b % 4
    f = (b + 8) / 25
    g = (b - f + 1) / 3
    h = (19 * a + b - d - g + 15) % 30
    i = c / 4
    k = c % 4
    l = (32 + 2 * e + 2 * i - h - k) % 7
    m = (a + 11 * h + 22 * l) / 451
    month = (h + l - 7 * m + 114) / 31
    day = ((h + l - 7 * m + 114) % 31) + 1
    Date.civil(year, month, day)
  end

  def self.dia_de_la_raza(fecha)
    # Si cae martes o miércoles, lunes anterior.
    # Si cae jueves o viernes, lunes siguiente.
    result = case fecha.wday
      when (1..3) then calculado(:segundo, :lunes, fecha.month, fecha.year)
      when (4..5) then calculado(:tercer, :lunes, fecha.month, fecha.year)
      else fecha
    end
  end

  def self.entre(fecha_inicial, fecha_final)
    fechas = {}
    lista = []
    (fecha_inicial..fecha_final).each do |fecha|
      fechas[fecha.year] = [0] unless fechas[fecha.year]      
      fechas[fecha.year] << fecha.month unless fechas[fecha.year].include?(fecha.month)
    end

    fechas.each do |anio,meses|
      meses.each do |mes|
        feriados = @feriados_por_mes[mes]
        if feriados
          feriados.each do |feriado|
            fecha = nil
            nombre = feriado[:nombre]
            if feriado[:funcion]
              fecha = feriado[:funcion].call(anio)
            end
            if feriado[:cambia_fijo]
              fecha = calculado(feriado[:cambia_fijo][0], feriado[:cambia_fijo][1], mes, anio)
            end
            if feriado[:cambia_variable]
              fecha = feriado[:cambia_variable].call(Date.civil(anio,mes,feriado[:dia]))
            end
            unless fecha
              fecha = Date.civil(feriado[:anio] || anio, mes, feriado[:dia])
            end
            if fecha.between?(fecha_inicial,fecha_final)
              lista << { :fecha => fecha, :nombre => nombre } if fecha.year == anio
            end
          end
        end
      end
    end
    lista.sort_by { |feriado| feriado[:fecha] }
  end

  def self.arr
    @feriados_por_mes
  end
end

class Date
  def es_feriado?
    feriados = Feriados.entre(self, self)
    feriados && !feriados.empty?
  end

  def es_fin_de_semana?
    self.wday == 6 or self.wday == 0
  end
end