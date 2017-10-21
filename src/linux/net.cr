require "./disk_common_types"

module Psutil
  module Linux
    extend self

    def net_io_counters(all = true)
      res = Array(Stats::NetIOCountersStat).new
      lines = File.read_lines("/proc/net/dev")
      lines[2..-1].each do |line|
        interface_name, counters_str = line.split(":").map { |x| x.strip }
        counters = counters_str.gsub(/\s+/, " ").split(" ").map { |x| x.strip }

        stat = Stats::NetIOCountersStat.new
        stat.name = interface_name
        stat.bytes_sent = counters[8].to_u64
        stat.bytes_recv = counters[0].to_u64
        stat.packets_sent = counters[9].to_u64
        stat.packets_recv = counters[1].to_u64
        stat.errin = counters[2].to_u64
        stat.errout = counters[10].to_u64
        stat.dropin = counters[3].to_u64
        stat.dropout = counters[11].to_u64
        stat.fifoin = counters[4].to_u64
        stat.fifoout = counters[12].to_u64
        res << stat
      end

      if all
        all_stat = Stats::NetIOCountersStat.new
        all_stat.name = "all"
        res.each do |stat|
          all_stat.bytes_sent += stat.bytes_sent
          all_stat.bytes_recv += stat.bytes_recv
          all_stat.packets_sent += stat.packets_sent
          all_stat.packets_recv += stat.packets_recv
          all_stat.errin += stat.errin
          all_stat.errout += stat.errout
          all_stat.dropin += stat.dropin
          all_stat.dropout += stat.dropout
          all_stat.fifoin += stat.fifoin
          all_stat.fifoout += stat.fifoout
        end
        res << all_stat
      end

      res
    end
  end
end
