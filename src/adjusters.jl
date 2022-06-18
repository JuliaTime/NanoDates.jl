### firstof

firstdayofyear(nd::NanoDate) = NanoDate(firstdayofyear(nd.datetime))
firstdayofquarter(nd::NanoDate) = NanoDate(firstdayofquarter(nd.datetime))
firstdayofmonth(nd::NanoDate) = NanoDate(firstdayofmonth(nd.datetime))
firstdayofweek(nd::NanoDate) = NanoDate(firstdayofweek(nd.datetime))

firsthourofday(nd::NanoDate) = trunc(nd, Day)
firstminuteofhour(nd::NanoDate) = trunc(nd, Hour)
firstsecondofminute(nd::NanoDate) = trunc(nd, Minute)
firstmillisecondofsecond(nd::NanoDate) = trunc(nd, Second)
firstmicrosecondofmillisecond(nd::NanoDate) = trunc(nd, Millisecond)
firstnanosecondofmicrosecond(nd::NanoDate) = trunc(nd, Microsecond)

### last of

lastdayofyear(nd::NanoDate) = NanoDate(lastdayofyear(nd.datetime))
lastdayofquarter(nd::NanoDate) = NanoDate(lastdayofquarter(nd.datetime))
lastdayofmonth(nd::NanoDate) = NanoDate(lastdayofmonth(nd.datetime))
lastdayofweek(nd::NanoDate) = NanoDate(lastdayofweek(nd.datetime))

lasthourofday(nd::NanoDate) = trunc(nd, Day) + Hour(23)
lastminuteofhour(nd::NanoDate) = trunc(nd, Hour) + Minute(59)
lastsecondofminute(nd::NanoDate) = trunc(nd, Minute) + Second(59)
lastmillisecondofsecond(nd::NanoDate) = trunc(nd, Second) + Millisecond(999)
lastmicrosecondofmillisecond(nd::NanoDate) = trunc(nd, Millisecond) + Microsecond(999)
lastnanosecondofmicrosecond(nd::NanoDate) = trunc(nd, Microsecond) + Nanosecond(999)
