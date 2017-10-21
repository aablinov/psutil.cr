module Psutil
  module Stats
    struct LoadAvgStat
      property load1 : Float64
      property load5 : Float64
      property load15 : Float64

      def initialize
        @load1 = 0_f64
        @load5 = 0_f64
        @load15 = 0_f64
      end
    end
  end
end
