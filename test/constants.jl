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

const adate = Date(yr, mn, dy)
const adatetime = DateTime(adate, atime_ms)

const ananosecs = nanosecs(Cs, Ns)
const ananodate = NanoDate(adatetime, ananosecs)

