# psutil.cr [![Build Status](https://api.travis-ci.org/kodnaplakal/psutil.cr.svg?branch=master)](https://travis-ci.org/kodnaplakal/psutil.cr)

This is a port of gopsutil [Gopsutil](https://github.com/shirou/gopsutil) a library for accessing information from the system for statistical purposes. It could be used for software that monitors the system for alerting or graphing purposes.

## Status

### OS support

- [x] Linux
- [ ] OSX

### Feature support

- [x] cpu_times
- [x] virtual_memory
- [x] disk_partitions
- [x] disk_usage
- [x] disk_io_counters
- [x] host_info
- [x] load_avg
- [x] net_io_counters

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  raven:
    github: kodnaplakal/psutil.cr
```

## Usage

```crystal
require "psutil"

puts Psutil.cpu_times
puts Psutil.virtual_memory
puts Psutil.disk_partitions
puts Psutil.disk_usage
puts Psutil.disk_io_counters
puts Psutil.host_info
puts Psutil.load_avg
puts Psutil.net_io_counters
```

## Development

```
crystal spec
```

## Contributing

1. [Fork it](https://github.com/kodnaplakal/psutil.cr/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new [Pull Request](https://github.com/kodnaplakal/psutil.cr/pulls)

## Contributors

- [kodnaplakal](https://github.com/kodnaplakal) Andrey Blinov - creator, maintainer
