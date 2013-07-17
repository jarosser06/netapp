NetApp
==================
requires 'snmp'

Wrapper for checking filer with snmp.

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
