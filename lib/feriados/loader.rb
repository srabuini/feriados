require 'ostruct'

module Feriados
  class Loader
    include Rules

    def initialize(data, calendar)
      @data = data
      @calendar = calendar
    end

    def load
      load_day_of_month
      load_functions
      load_fix_week_days
      load_fix_days
    end

    private

    attr_reader :data, :calendar

    def load_day_of_month
      day_of_month.each do |month, rules|
        rules.each do |rule_data|
          rule = OpenStruct.new(rule_data)
          calendar.add(DayOfMonth.new(rule.day, month, rule.name))
        end
      end
    end

    def load_functions
      function.each do |function, name|
        function_name = function.split('_').collect(&:capitalize).join
        class_name = "Feriados::Rules::#{function_name}".split('::')

        klass = class_name.inject(Object) { |obj, const| obj.const_get(const) }
        klass.name = name
        calendar.add(klass)
      end
    end

    def load_fix_week_days
      fix_week_day.each do |month, rules|
        rules.each do |rule_data|
          rule = OpenStruct.new(rule_data)
          calendar.add(FixWeekDay.new(rule.week, rule.day, month, rule.name))
        end
      end
    end

    def load_fix_days
      fix_day.each do |year, months|
        months.each do |month, rules|
          rules.each do |rule_data|
            rule = OpenStruct.new(rule_data)
            calendar.add(FixDate.new(year, month, rule.day, rule.name))
          end
        end
      end
    end

    def day_of_month
      data['day_of_month']['month']
    end

    def function
      data['function']
    end

    def fix_week_day
      data['fix_week_day']['month']
    end

    def fix_day
      data['fix_day']
    end
  end
end
