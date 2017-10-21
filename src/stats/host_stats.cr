module Psutil
  module Stats
    struct HostInfoStat
      property hostname : String
      property uptime : UInt64    # /proc/uptime
      property boot_time : UInt64 # /proc/stat btime
      property procs : UInt64
      property os : String
      property platform : String
      property platform_version : String
      property kernel_version : String
      property host_id : String
      property arch : String

      def initialize
        @hostname = ""
        @uptime = 0_u64
        @boot_time = 0_u64
        @procs = 0_u64
        @os = ""
        @platform = ""
        @platform_version = ""
        @kernel_version = ""
        @host_id = ""
        @arch = ""
      end
    end
  end
end
