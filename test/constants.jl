const yr = 2022
const mn = 7
const dy = 28
const hr = 10
const mi = 20
const sc = 8
const ms = 350
const cs = 789
const ns = 420

const Yr = Year(yr)
const Mn = Month(mn)
const Dy = Day(dy)
const Hr = Hour(hr)
const Mi = Minute(mi)
const Sc = Second(sc) 
const Ms = Millisecond(ms)
const Cs = Microsecond(cs)
const Ns = Nanosecond(ns)

const tyme = Time(hr, mi, sc, ms, cs, ns)
const tyme_sc = Time(hr, mi, sc)
const tyme_ms = Time(hr, mi, sc, ms)
const earliertime = tyme - Minute(4) - Microsecond(12)
const latertime = tyme + Minute(4) + Microsecond(12)
const earliertime_ms = tyme_ms - Minute(4)
const latertime_ms = tyme_ms + Minute(4)

const dayte = Date(yr, mn, dy)
const earlierdate = dayte - Month(1) - Day(5)
const laterdate = dayte + Month(1) + Day(5)

const daytime = DateTime(dayte, tyme_ms)
const earlierdatetime = DateTime(earlierdate, earliertime_ms)
const laterdatetime = DateTime(laterdate, latertime_ms)

const ananosecs = nanosecs(Cs, Ns)
const earliernanosecs = nanosecs(Cs-Microsecond(12), Ns-Nanosecond(100))
const laternanosecs = nanosecs(Cs+Microsecond(12), Ns+Nanosecond(100))

const nd = NanoDate(daytime, ananosecs)
const earliernanodate = NanoDate(earlierdatetime, earliernanosecs)
const laternanodate = NanoDate(laterdatetime, laternanosecs)
const nd0 = NanoDate(daytime)
const nd00 = NanoDate(dayte)

