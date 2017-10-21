module Psutil
  module Unix
    lib LibUnix
      struct Statfs
        f_type : X__FswordT
        f_bsize : X__FswordT
        f_blocks : X__FsblkcntT
        f_bfree : X__FsblkcntT
        f_bavail : X__FsblkcntT
        f_files : X__FsfilcntT
        f_ffree : X__FsfilcntT
        f_fsid : X__FsidT
        f_namelen : X__FswordT
        f_frsize : X__FswordT
        f_flags : X__FswordT
        f_spare : X__FswordT[4]
      end

      alias X__FswordT = LibC::Long
      alias X__FsblkcntT = LibC::ULong
      alias X__FsfilcntT = LibC::ULong

      struct X__FsidT
        __val : LibC::Int[2]
      end

      fun statfs(__file : LibC::Char*, __buf : Statfs*) : LibC::Int

      struct Utsname
        sysname : LibC::Char[65]
        nodename : LibC::Char[65]
        release : LibC::Char[65]
        version : LibC::Char[65]
        machine : LibC::Char[65]
        __domainname : LibC::Char[65]
      end

      fun uname(__name : Utsname*) : LibC::Int
    end
  end
end
