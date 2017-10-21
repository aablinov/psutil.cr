module Psutil
  module Unix
    extend self

    def disk_usage(path = "/")
      res = Stats::DiskUsageStat.new
      s_statfs = LibUnix::Statfs.new
      status = LibUnix.statfs(path, pointerof(s_statfs))

      raise "Error when getting statfs for path: #{path}" if status == -1

      res.path = path
      res.fstype = get_fs_type(s_statfs.f_type)
      res.total = s_statfs.f_blocks * s_statfs.f_bsize
      res.free = s_statfs.f_bavail * s_statfs.f_bsize
      res.inodes_total = s_statfs.f_files
      res.inodes_free = s_statfs.f_ffree

      return res if res.inodes_total < res.inodes_free

      res.inodes_used = (res.inodes_total - res.inodes_free)
      res.used = (s_statfs.f_blocks - s_statfs.f_bfree) * s_statfs.f_bsize

      if res.inodes_total == 0
        res.inodes_used_percent = 0.0_f64
      else
        res.inodes_used_percent = ((res.inodes_used.to_f64 / res.inodes_total.to_f64) * 100.0_f64).round(3)
      end

      if res.total == 0
        res.used_percent = 0.0_f64
      else
        res.used_percent = ((res.used.to_f64 / res.total.to_f64) * 100.0_f64).round(3)
      end

      res
    end
  end
end
