module Psutil
  module Linux
    CPU_TICK = 100_f64
    extend self

    def cpu_times(per_cpu = true)
      res = Array(Stats::CPUTimesStat).new
      lines = File.read_lines("/proc/stat")
      lines = lines[0..0] if per_cpu == false
      lines.each do |line|
        next unless line.starts_with?("cpu")
        fields = line.split(/\s+/)

        stat = Stats::CPUTimesStat.new

        stat.cpu = fields[0] == "cpu" ? "cpu-total" : fields[0]
        stat.user = fields[1].to_f64 / CPU_TICK
        stat.nice = fields[2].to_f64 / CPU_TICK
        stat.system = fields[3].to_f64 / CPU_TICK
        stat.idle = fields[4].to_f64 / CPU_TICK
        stat.iowait = fields[5].to_f64 / CPU_TICK
        stat.irq = fields[6].to_f64 / CPU_TICK
        stat.softirq = fields[7].to_f64 / CPU_TICK

        stat.steal = fields[8].to_f64 / CPU_TICK if fields.size > 8 # Linux >= 2.6.11

        stat.guest = fields[9].to_f64 / CPU_TICK if fields.size > 9 # Linux >= 2.6.24

        stat.guest_nice = fields[10].to_f64 / CPU_TICK if fields.size > 10 # Linux >= 3.2.0
        res << stat
      end
      res
    end
  end
end
