module Feriados
  module Rules
    class RuleBase
      attr_reader :name

      def initialize(name = nil)
        @name = name
      end

      def hash
        state.hash
      end

      def eql?(other)
        hash == other.hash
      end

      def ==(other)
        eql?(other)
      end
    end
  end
end
