Feriados
========

Make a calendar and add it rules for holidays.

Install
-------

    gem install feriados

How to use it
-------------

``` ruby
require 'feriados'

calendar = Feriados::Calendar.new

calendar.add Feriados::Rules::DayOfWeek.new(0)

calendar.holiday?(Date.new(2016, 5, 1)) #=> true
```

You can use a refinement for `Date` class:

``` ruby
using Feriados

# Set a calendar to Date class
Date.calendar = calendar

Date.new(2016, 5, 1).holiday? #=> true
```
