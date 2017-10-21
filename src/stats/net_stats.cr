module Psutil
  module Stats
    struct NetIOCountersStat
      property name : String
      property bytes_sent : UInt64
      property bytes_recv : UInt64
      property packets_sent : UInt64
      property packets_recv : UInt64
      property errin : UInt64
      property errout : UInt64
      property dropin : UInt64
      property dropout : UInt64
      property fifoin : UInt64
      property fifoout : UInt64

      def initialize
        @name = ""
        @bytes_sent = 0_u64
        @bytes_recv = 0_u64
        @packets_sent = 0_u64
        @packets_recv = 0_u64
        @errin = 0_u64
        @errout = 0_u64
        @dropin = 0_u64
        @dropout = 0_u64
        @fifoin = 0_u64
        @fifoout = 0_u64
      end
    end
  end
end
