## enhancements

#### provides timestamps

- NanoDate ⇌ timestamp


- ISO8061 UTC times, end with 'Z'
    - `timestamp(::NanoDate; utc=true)`


- ISO8061 local times, end with offset from UTC ("±hh:mm")
    - `timestamp(::NanoDate; localtime=true)`

- wallclock time (hours & minutes adjusted to localtime)
    - `timestamp(::NanoDate; localtime=true, postfix=false)`


#### splicing into periods

- replace Hour(nd) with Hour(5)
    - `NanoDate(nd, Hour(5))`
- move to Week(2) of Year(nd)
    - `NanoDate(nd, Week(2))`


#### readability options

- separate subseconds
    - `NanoDate("2022-04-28T02:15:30.124_455_82")`
- substitute space (' ') for 'T' as separator
    - `NanoDate("2022-04-28 02:15:30.124_455_82")`
