require 'ostruct'
require 'forwardable'

require_relative './rules/rule_base'
require_relative './rules/function'
require_relative './rules/carnival_monday'
require_relative './rules/carnival_tuesday'
require_relative './rules/day_of_month'
require_relative './rules/day_of_week'
require_relative './rules/easter'
require_relative './rules/fix_date'
require_relative './rules/fix_week_day'
require_relative './rules/holy_friday'
require_relative './rules/holy_thursday'

module Feriados
  module Rules
    class Rule
      extend Forwardable

      def_delegators :@rule, :day, :month, :year, :week

      attr_reader :rule

      def initialize(rule)
        @rule = OpenStruct.new(rule)
      end

      def week_day?
        rule.day && rule.month && rule.week
      end

      def fix_date?
        rule.day && rule.month && rule.year
      end

      def day_of_month?
        rule.day && rule.month && !fix_date? && !week_day?
      end

      def function?
        functions = %i[easter holy_thursday holy_friday carnival_monday
                       carnival_tuesday]

        functions.map { |e| rule.respond_to?(e) }.any?
      end

      def name
        rule[:name] || rule.to_h.values.first
      end

      def function_name
        rule.to_h.keys.first.to_s.split('_').collect(&:capitalize).join
      end
    end

    def self.create_with(rule)
      rule = Rule.new(rule)
      return DayOfMonth.new(rule.day, rule.month, rule.name) if rule.day_of_month?
      return FixWeekDay.new(rule.week, rule.day, rule.month, rule.name) if rule.week_day?
      return FixDate.new(rule.year, rule.month, rule.day, rule.name) if rule.fix_date?

      raise ArgumentError, "Argument #{rule} is not a valid rule" unless rule.function?

      function_name = rule.function_name
      class_name = "Feriados::Rules::#{function_name}".split('::')
      klass = class_name.inject(Object) { |obj, const| obj.const_get(const) }
      klass.name = rule.name

      klass
    end
  end
end
