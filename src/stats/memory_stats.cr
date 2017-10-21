module Psutil
  module Stats
    struct VirtualMemoryStat
      property total : UInt64
      property available : UInt64
      property free : UInt64
      property used : UInt64
      property used_percent : Float64
      # // OS X / BSD specific numbers:
      # // http://www.macyourself.com/2010/02/17/what-is-free-wired-active-and-inactive-system-memory-ram/
      property active : UInt64
      property inactive : UInt64
      property wired : UInt64
      # // Linux specific numbers
      # // https://www.centos.org/docs/5/html/5.1/Deployment_Guide/s2-proc-meminfo.html
      # // https://www.kernel.org/doc/Documentation/filesystems/proc.txt
      property buffers : UInt64
      property cached : UInt64
      property writeback : UInt64
      property dirty : UInt64
      property writeback_tmp : UInt64
      property shared : UInt64
      property slab : UInt64
      property page_tables : UInt64
      property swap_cached : UInt64
      property swap_total : UInt64
      property swap_free : UInt64

      def initialize
        @total = 0_u64
        @available = 0_u64
        @free = 0_u64
        @used = 0_u64
        @active = 0_u64
        @inactive = 0_u64
        @wired = 0_u64
        @buffers = 0_u64
        @cached = 0_u64
        @writeback = 0_u64
        @dirty = 0_u64
        @writeback_tmp = 0_u64
        @shared = 0_u64
        @slab = 0_u64
        @page_tables = 0_u64
        @swap_cached = 0_u64
        @swap_total = 0_u64
        @swap_free = 0_u64
        @used_percent = 0.0
      end
    end
  end
end
