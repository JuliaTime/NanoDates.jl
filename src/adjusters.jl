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
