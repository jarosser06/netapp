netapp_filer_query
==================

requires 'snmp'

Wrapper for checking filer with snmp

This should allow for querying information from netapp filer storage.

Including listing all current volumes, the total allocated storage on each volume and even allow converting to human readable ie (MB, GB, TB).

This should be able to list other information like current temps, failed disks, etc.


Get Volume Total Size in TB
---------------------------

```ruby
require 'netapp'

filer = NetApp.new("192.168.1.20")
test_vol = filer.volume("/vol/test1/")
test_vol.total.to_u(:TB)
```

Print Out Volume Used in Human Readable String
----------------------------------------------

```ruby
require 'netapp'

filer = NetApp.new("192.168.1.20")
test_vol = filer.volume("/vol/test1/")
test_vol.used.to_h(:GB)
```
