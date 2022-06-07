### trunction

Base.trunc(nd::NanoDate, p::Type{Year}) = NanoDate(trunc(Date(nd), Year))
Base.trunc(nd::NanoDate, p::Type{Quarter}) = NanoDate(trunc(Date(nd), Quarter))
Base.trunc(nd::NanoDate, p::Type{Month}) = NanoDate(trunc(Date(nd), Month))
Base.trunc(nd::NanoDate, p::Type{Day}) = NanoDate(Date(nd))
Base.trunc(nd::NanoDate, p::Type{Hour}) = nd - (Minute(nd) + Second(nd) + Millisecond(nd))
Base.trunc(nd::NanoDate, p::Type{Minute}) = nd - (Second(nd) + Millisecond(nd))
Base.trunc(nd::NanoDate, p::Type{Second}) = nd - Millisecond(nd)
Base.trunc(nd::NanoDate, p::Type{Millisecond}) = nd - div(nd.nanosecs, NanosecondsPerMillisecond)
Base.trunc(nd::NanoDate, p::Type{Microsecond}) = nd - rem(nd.nanosecs, NanosecondsPerMicrosecond)
Base.trunc(nd::NanoDate, p::Type{Nanosecond}) = nd

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
