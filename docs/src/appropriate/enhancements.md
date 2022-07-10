## enhancements

### timestamps

##### NanoDate ⇌ timestamp
- roundtrip construction
- parsing with dateformat


##### ISO8061
- UTC times, end with 'Z'
  - `timestamp(::NanoDate; utc=true)`

- local times, end with offset from UTC ("±hh:mm")
  - `timestamp(::NanoDate; localtime=true)`

##### wallclock time
- hours & minutes adjusted to localtime
  - `timestamp(::NanoDate; localtime=true, postfix=false)`


### splicing into periods

- replace Hour(nd) with Hour(5)
  - `NanoDate(nd, Hour(5))`
- move to Week(2) of Year(nd)
  - `NanoDate(nd, Week(2))`


### readability options (nd  ⇌ timestamp )

- subsecond separator
  - `NanoDate("2022-06-18T12:15:30.123_455_820")`
- substitute a space for 'T'
  - `NanoDate("2022-04-28 12:15:30")`
