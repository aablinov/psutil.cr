require "./disk_common_types"

module Psutil
  module Linux
    extend self

    def load_avg
      stat = Stats::LoadAvgStat.new
      content = File.read("/proc/loadavg")
      fields = content.split(" ")
      stat.load1 = fields[0].to_f64
      stat.load5 = fields[1].to_f64
      stat.load15 = fields[2].to_f64
      stat
    end
  end
end
