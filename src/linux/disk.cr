require "./disk_common_types"

module Psutil
  module Linux
    extend self

    DISK_SECTOR_SIZE = 512

    def disk_usage(path = "/")
      Unix.disk_usage(path)
    end

    def disk_partitions(all = false)
      res = Array(Stats::DiskPartitionStat).new
      lines = File.read_lines("/proc/self/mounts")
      fs = get_file_systems
      lines.each do |line|
        fields = line.split(/\s+/).map { |x| x.strip }
        stat = Stats::DiskPartitionStat.new
        stat.device = fields[0]
        stat.mountpoint = fields[1]
        stat.fstype = fields[2]
        stat.opts = fields[3]
        if all == false
          if stat.device == "none" || !fs.includes?(stat.fstype)
            next
          end
        end
        res << stat
      end
      res
    end

    def disk_io_counters
      res = Array(Stats::DiskIOCountersStat).new
      lines = File.read_lines("/proc/diskstats")
      lines.each do |line|
        fields = line.gsub(/\s+/, " ").strip.split(" ")
        next if fields.size < 14
        stat = Stats::DiskIOCountersStat.new
        stat.name = fields[2]
        stat.read_count = fields[3].to_u64
        stat.merge_read_count = fields[4].to_u64
        stat.read_bytes = fields[5].to_u64 * DISK_SECTOR_SIZE
        stat.read_time = fields[6].to_u64
        stat.write_count = fields[7].to_u64
        stat.merge_write_count = fields[8].to_u64
        stat.write_bytes = fields[9].to_u64 * DISK_SECTOR_SIZE
        stat.write_time = fields[10].to_u64
        stat.iops_in_progress = fields[11].to_u64
        stat.io_time = fields[12].to_u64
        stat.weighted_io = fields[12].to_u64
        stat.serial_number = get_disk_serial_number(stat.name)
        res << stat
      end
      res
    end

    private def get_disk_serial_number(name : String)
      return "" unless File.exists?("/sbin/udevadm")

      output = %x{/sbin/udevadm info --query=property --name=#{name}}
      serial = ""
      output.each_line do |line|
        values = line.split("=")
        next if values.size < 2 || values[0] != "ID_SERIAL"
        serial = values[1]
      end
      serial
    end

    private def get_file_systems
      res = Array(String).new
      lines = File.read_lines("/proc/filesystems")
      lines.each do |line|
        next if line.starts_with?("nodev")
        res << line.strip
      end
      res + ["cifs", "nfs", "nfs4", "fuse"]
    end
  end

  module Unix
    private def get_fs_type(code : Int64) : String
      Linux::FS_TYPES_MAP[code] || ""
    end
  end
end
