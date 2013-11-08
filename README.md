feriados
========

Feriados argentinos. Extiende la clase Date, agregando los métodos:

    es_feriado?

y

    es_fin_de_semana?

Instalacion
-----------

    gem install feriados

Uso
---

``` ruby
require 'feriados'
require 'feriados/argentina'

Date.civil(2013, 5, 1).es_feriado? #=> true
```
