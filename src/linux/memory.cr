module Psutil
  module Linux
    extend self

    def virtual_memory
      res = Stats::VirtualMemoryStat.new
      lines = File.read_lines("/proc/meminfo")
      # flag if MemAvailable is in /proc/meminfo (kernel 3.14+)
      memavail = false

      lines.each do |line|
        fields = line.split(":").map { |x| x.strip }
        next if fields.size != 2

        k, v = fields
        v = v.gsub(" kB", "").strip.to_u64 * 1024 # Kb to bytes

        case k
        when "MemTotal"
          res.total = v
        when "MemFree"
          res.free = v
        when "MemAvailable"
          memavail = true
          res.available = v
        when "Active"
          res.active = v
        when "Inactive"
          res.inactive = v
        when "Wired"
          res.wired = v
        when "Cached"
          res.cached = v
        when "Writeback"
          res.writeback = v
        when "Dirty"
          res.dirty = v
        when "WritebackTmp"
          res.writeback_tmp = v
        when "Shared"
          res.shared = v
        when "Slab"
          res.slab = v
        when "PageTables"
          res.page_tables = v
        when "SwapCached"
          res.swap_cached = v
        when "SwapTotal"
          res.swap_total = v
        when "SwapFree"
          res.swap_free = v
        end
      end
      unless memavail
        res.available = res.free + res.buffers + res.cached
      end
      res.used = res.total - res.available
      res.used_percent = (res.used.to_f64 / res.total.to_f64 * 100.0).round(3)

      res
    end
  end
end
