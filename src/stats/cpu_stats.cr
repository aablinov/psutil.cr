module Psutil
  module Stats
    struct CPUTimesStat
      property cpu : String
      property user : Float64
      property system : Float64
      property idle : Float64
      property nice : Float64
      property iowait : Float64
      property irq : Float64
      property softirq : Float64
      property steal : Float64
      property guest : Float64
      property guest_nice : Float64
      property stolen : Float64

      def initialize
        @cpu = ""
        @user = 0.0
        @system = 0.0
        @idle = 0.0
        @nice = 0.0
        @iowait = 0.0
        @irq = 0.0
        @softirq = 0.0
        @steal = 0.0
        @guest = 0.0
        @guest_nice = 0.0
        @stolen = 0.0
      end
    end
  end
end
