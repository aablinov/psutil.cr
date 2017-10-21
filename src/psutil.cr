require "./stats/**"
{% if flag?(:linux) %}
  require "./unix/lib_unix"
  require "./unix/disk"
  require "./linux/cpu"
  require "./linux/memory"
  require "./linux/disk"
  require "./linux/host"
  require "./linux/load"
  require "./linux/net"
{% end %}

module Psutil
  VERSION = "0.0.1"

  {% if flag?(:linux) %}
    extend Linux
  {% end %}
end
