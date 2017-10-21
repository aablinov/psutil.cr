module Psutil
  module Stats
    struct DiskPartitionStat
      property device : String
      property mountpoint : String
      property fstype : String
      property opts : String

      def initialize
        @device = ""
        @mountpoint = ""
        @fstype = ""
        @opts = ""
      end
    end

    struct DiskUsageStat
      property path : String
      property fstype : String
      property total : UInt64
      property free : UInt64
      property used : UInt64
      property used_percent : Float64
      property inodes_total : UInt64
      property inodes_used : UInt64
      property inodes_free : UInt64
      property inodes_used_percent : Float64

      def initialize
        @path = ""
        @fstype = ""
        @total = 0_u64
        @free = 0_u64
        @used = 0_u64
        @inodes_total = 0_u64
        @inodes_used = 0_u64
        @inodes_free = 0_u64
        @used_percent = 0.0_f64
        @inodes_used_percent = 0.0_f64
      end
    end

    struct DiskIOCountersStat
      property read_count : UInt64
      property merge_read_count : UInt64
      property write_count : UInt64
      property merge_write_count : UInt64
      property read_bytes : UInt64
      property write_bytes : UInt64
      property read_time : UInt64
      property write_time : UInt64
      property iops_in_progress : UInt64
      property io_time : UInt64
      property weighted_io : UInt64
      property name : String
      property serial_number : String

      def initialize
        @read_count = 0_u64
        @merge_read_count = 0_u64
        @write_count = 0_u64
        @merge_write_count = 0_u64
        @read_bytes = 0_u64
        @write_bytes = 0_u64
        @read_time = 0_u64
        @write_time = 0_u64
        @iops_in_progress = 0_u64
        @io_time = 0_u64
        @weighted_io = 0_u64
        @name = ""
        @serial_number = ""
      end
    end
  end
end
