require "./disk_common_types"

module Psutil
  module Linux
    extend self

    def host_info
      stat = Stats::HostInfoStat.new

      utsname = Unix::LibUnix::Utsname.new

      if Unix::LibUnix.uname(pointerof(utsname)) < 0
        raise "Error when getting uname"
      end

      stat.os = String.new(utsname.sysname.to_unsafe)
      stat.hostname = String.new(utsname.nodename.to_unsafe)
      stat.kernel_version = String.new(utsname.release.to_unsafe)
      stat.arch = String.new(utsname.machine.to_unsafe)
      stat.host_id = get_host_id
      stat.boot_time = get_boot_time
      stat.uptime = (Time.now.epoch - stat.boot_time).to_u64
      stat.procs = Dir.entries("/proc").size.to_u64
      lsb = get_lsb
      stat.platform = lsb.id
      stat.platform_version = lsb.release
      stat
    end

    private def get_host_id
      id = ""
      if File.exists?("class/dmi/id/product_uuid")
        lines = File.read_lines("class/dmi/id/product_uuid")
        id = lines[0] if lines.size > 0 && lines[0] != ""
      end

      if id.empty?
        id = sysctl_host_id
      end
      id.gsub("\n", "").downcase
    end

    private def sysctl_host_id
      %x{sysctl kernel.random.boot_id -n}
    end

    private def get_boot_time
      lines = File.read_lines("/proc/stat")
      btime = 0_u64
      lines.each do |line|
        fields = line.split(/\s+/)
        if fields[0] == "btime"
          btime = fields[1].to_u64
        end
      end
      btime
    end

    struct LSB
      property id : String
      property release : String
      property codename : String
      property description : String

      def initialize
        @id = ""
        @release = ""
        @codename = ""
        @description = ""
      end
    end

    private def get_lsb
      ret = LSB.new
      if File.exists?("/etc/lsb-release")
        lines = File.read_lines("/etc/lsb-release")
        lines.each do |line|
          fields = line.split("=").map { |x| x.gsub("\"", "").strip }
          next if fields.size < 2
          key, value = fields[0], fields[1]
          case key
          when "DISTRIB_ID"
            ret.id = value
          when "DISTRIB_RELEASE"
            ret.release = value
          when "DISTRIB_CODENAME"
            ret.codename = value
          when "DISTRIB_DESCRIPTION"
            ret.description = value
          end
        end
      elsif File.exists?("/usr/bin/lsb_release")
        content = %x{/usr/bin/lsb_release}
        content.split("\n").each do |line|
          fields = line.split(":").map { |x| x.gsub("\"", "").strip }
          next if fields.size < 2
          key, value = fields[0], fields[1]
          case key
          when "Distributor ID"
            ret.id = value
          when "Release"
            ret.release = value
          when "Codename"
            ret.codename = value
          when "Description"
            ret.description = value
          end
        end
      end
      ret
    end
  end
end
