Feriados
========

Feriados argentinos. Extiende la clase Date, agregando los métodos:

    is_holiday?

y

    is_weekend?

Instalacion
-----------

    gem install feriados

Uso
---

``` ruby
require 'feriados'
require 'feriados/argentina'

Date.civil(2013, 5, 1).is_holiday? #=> true
```
