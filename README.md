# Feriados

Create a calendar and add it rules for holidays.

## Install

    gem install feriados

## How to use it

A rule is an object that responds to `holiday?(date)` and `name`. There are four
kinds of rules included in Feriados:

### DayOfMonth

`DayOfMonth` is a holiday that occurs the same day and month every year,
like *New Year*.

``` ruby
require 'feriados'

calendar = Feriados::Calendar.new

calendar.add Feriados::Rules::DayOfMonth.new(1, 1, 'New Year')

date = Date.new(2020, 1, 1)

calendar.holiday?(date) #=> true

calendar.holiday_name(date) #=> New Year
```
### FixWeekDay

`FixWeekDay` is a holiday that happens each year the same week day the nth week,
like *the fourth Thursday of November*.

``` ruby
calendar.add Feriados::Rules::FixWeekDay.new(4, 4, 11, 'Thanksgiving')

date = Date.new(2020, 11, 26)

calendar.holiday?(date) #=> true

calendar.holiday_name(date) #=> Thanksgiving
```

### Function

`Function` is a holiday that is calculated for every year, like *Easter*

``` ruby
calendar.add Feriados::Rules::Easter

date = Date.new(2020, 4, 12)

calendar.holiday?(date) #=> true

calendar.holiday_name(date) #=> nil

# You might add a name to easter

Feriados::Rules::Easter.name = 'Easter'

calendar.holiday_name(date) #=> Easter

```
The other included *Functions* in Feriados are: `HolyThursday`,
 `HolyFriday`, `CarnivalMonday`, `CarnivalTuesday`.

### FixDate

`FixDate` is a holiday that happens on a date on an specific year,
like *2020 RubyConf*.

``` ruby
calendar.add Feriados::Rules::FixDate.new(2020, 11, 17, 'RubyConf')

date = Date.new(2020, 11, 17)

calendar.holiday?(date) #=> true

calendar.holiday_name(date) #=> RubyConf
```

## Adding rules massively

It is possible to add rules using a `Hash`.

```ruby
rules = [{
  month: 1,
  day: 1,
  name: 'New Year'
}, {
  easter: 'Easter'
}, {
  holy_thursday: 'Holy Thursday'
}, {
  holy_friday: 'Holy Friday'
}, {
  carnival_monday: 'Carnival Monday'
}, {
  carnival_tuesday: 'Carnival Tuesday'
}, {
  month: 11,
  day: 4,
  week: 4,
  name: 'Thanksgiving'
}, {
  year: 2020,
  month: 11,
  day: 17,
  name: 'RubyConf'
}]

calendar.load rules
```

Or you could use a `YAML` file like [test/argentina.yml](test/argentina.yml).

```ruby
rules = YAML.load_file(file_with_rules)

calendar.load(rules)
```

## Refinements

It is possible to use a refinement for `Date` class:

``` ruby
require 'feriados'

using Feriados

calendar = Feriados::Calendar.new

calendar.add Feriados::Rules::Easter
Feriados::Rules::Easter.name = 'Easter'

# Set a calendar to Date class
Date.calendar = calendar

Date.new(2020, 4, 12).holiday? #=> true
Date.new(2020, 4, 12).holiday_name #=> Easter
```
