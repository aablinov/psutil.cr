require "./spec_helper"

describe Psutil, "Psutil all specs" do
  context "#cpu_times" do
    it "common behavior" do
      stat = Psutil.cpu_times(false).first
      stat.cpu.should eq "cpu-total"
      stat.user.should be > 0
      stat.system.should be > 0
      stat.idle.should be > 0
      stat.iowait.should be > 0
    end
  end

  context "#virtual_memory" do
    it "common behavior" do
      mem = Psutil.virtual_memory
      mem.total.should be > 0
      mem.available.should be > 0
      mem.free.should be > 0
      mem.used.should be > 0
      mem.used_percent.should be > 0
    end
  end

  context "#disk_partitions" do
    it "common behavior" do
      partition = Psutil.disk_partitions.first
      partition.device.should_not eq ""
      partition.mountpoint.should_not eq ""
      partition.fstype.should_not eq ""
      partition.opts.should_not eq ""
    end
  end

  context "#disk_usage" do
    it "common behavior" do
      usage = Psutil.disk_usage
      usage.path.should eq "/"
      usage.fstype.should_not eq ""
      usage.total.should be > 0
      usage.free.should be > 0
      usage.used.should be > 0
      usage.used_percent.should be > 0
      usage.inodes_total.should be > 0
      usage.inodes_used.should be > 0
      usage.inodes_free.should be > 0
      usage.inodes_used_percent.should be > 0
    end
  end

  context "#disk_io_counters" do
    it "common behavior" do
      disk_io_counters = Psutil.disk_io_counters
      stat = Psutil::Stats::DiskIOCountersStat.new
      Psutil.disk_partitions.each do |part|
        stat = disk_io_counters.find { |v| part.device.ends_with?(v.name) }
      end
      stat.should_not be_nil
      if stat
        stat.read_count.should be > 0
        stat.merge_read_count.should be > 0
        stat.write_count.should be > 0
        stat.merge_write_count.should be > 0
        stat.read_bytes.should be > 0
        stat.write_bytes.should be > 0
        stat.read_time.should be > 0
        stat.write_time.should be > 0
        stat.io_time.should be > 0
        stat.weighted_io.should be > 0
        stat.name.should_not eq ""
        stat.serial_number.should_not eq ""
      end
    end
  end

  context "#host_info" do
    it "common behavior" do
      stat = Psutil.host_info
      stat.hostname.should_not eq ""
      stat.uptime.should be > 0
      stat.boot_time.should be > 0
      stat.procs.should be > 0
      stat.os.should_not eq ""
      stat.platform.should_not eq ""
      stat.platform_version.should_not eq ""
      stat.kernel_version.should_not eq ""
      stat.host_id.should_not eq ""
      stat.arch.should_not eq ""
    end
  end

  context "#load_avg" do
    it "not raise errors" do
      Psutil.load_avg
    end
  end

  context "#net_io_counters" do
    it "common behavior" do
      Psutil.net_io_counters.size.should be > 0
    end
  end
end
