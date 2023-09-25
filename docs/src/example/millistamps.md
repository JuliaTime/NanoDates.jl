#### Timestamping from Milliseconds

```
using Dates, NanoDates

# an appropriate Time0 for this use case, it is a NanoDate
# NanoDates support adding and subtracting many Milliseconds

const UnixEpoch = NanoDate(DateTime(1970,1,1)) 

# mapping Milliseconds relative to the UnixEpoch onto NanoDates

millis2nanodate(millis::Millisecond) = UnixEpoch + millis

# mapping Milliseconds relative to the UnixEpoch into timestamps

millis2timestamp(millis::Millisecond; utc=true, postfix=false) =
    timestamp(millis2nanodate(millis); utc, postfix)

millis_today    = Millisecond( now() - UnixEpoch)
millis_lastyear = Millisecond( (now() - Year(1)) - UnixEpoch)

today    = millis2nanodate(millis_today)
lastyear = millis2nanodate(millis_lastyear)

timestamp_today    = millis2timestamp(millis_today; utc=false)
timestamp_lastyear = millis2timestamp(millis_lastyear; postfix=true)

```
