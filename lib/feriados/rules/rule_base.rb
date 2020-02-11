module Feriados
  module Rules
    class RuleBase
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
