const yr = 2022
const mn = 7
const dy = 28
const hr = 10
const mi = 20
const sc = 0
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

const atime = Time(hr, mi, sc, ms, cs, ns)
const atime_sc = Time(hr, mi, sc)
const atime_ms = Time(hr, mi, sc, ms)
const earliertime = atime - Minute(4) - Microsecond(12)
const latertime = atime + Minute(4) + Microsecond(12)
const earliertime_ms = atime - Minute(4)
const latertime_ms = atime + Minute(4)

const adate = Date(yr, mn, dy)
const earlierdate = adate - Month(1) - Day(5)
const laterdate = adate + Month(1) + Day(5)

const adatetime = DateTime(adate, atime_ms)
const earlierdatetime = DateTime(earlierdate, earliertime_ms)
const laterdatetime = DateTime(laterdate, latertime_ms)

const ananosecs = nanosecs(Cs, Ns)
const earliernanosecs = nanosecs(Cs-Microsecond(12), Ns-Nanosecond(100))
const laternanosecs = nanosecs(Cs+Microsecond(12), Ns+Nanosecond(100))

const ananodate = NanoDate(adatetime, ananosecs)
const ananodate0 = NanoDate(adatetime)
const earliernanodate = NanoDate(earlierdatetime, earliernanosecs)
const laternanodate = NanoDate(laterdatetime, laternanosecs)
