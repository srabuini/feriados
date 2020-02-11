module Feriados
  class Loader
    def initialize(file, calendar)
      @file = file
      @calendar = calendar
    end

    def load
      load_day_of_month
      load_functions
      load_fix_weekdays
      load_fix_days
    end

    private

    attr_reader :file, :calendar

    def config_rules
      @config_rules ||= YAML.load_file(file)
    end

    def load_day_of_month
      config_rules['months'].each do |month, rules|
        rules.each do |rule|
          calendar.add(Rules::DayOfMonth.new(rule['day'], month))
        end
      end
    end

    def load_functions
      config_rules['functions'].each do |rule|
        function_name = rule.split('_').collect(&:capitalize).join
        class_name = "Feriados::Rules::#{function_name}".split('::')

        klass = class_name.inject(Object) { |obj, const| obj.const_get(const) }
        calendar.add(klass)
      end
    end

    def load_fix_weekdays
      config_rules['fix_weekdays']['months'].each do |month, rules|
        rules.each do |rule|
          calendar.add(Rules::FixWeekDay.new(rule['week'], rule['day'], month))
        end
      end
    end

    def load_fix_days
      config_rules['fix_days'].each do |year, months|
        months.each do |month, rules|
          rules.each do |rule|
            calendar.add(Rules::FixDate.new(year, month, rule['day']))
          end
        end
      end
    end
  end
end
