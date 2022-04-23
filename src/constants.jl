const DaysPerWeek = Int64(7)
const HoursPerDay = Int64(24)
const MinutesPerHour = Int64(60)
const SecondsPerMinute = Int64(60)
const MillisecondsPerSecond = Int64(1_000)
const MicrosecondsPerMillisecond = Int64(1_000)
const NanosecondsPerMicrosecond = Int64(1_000)

const HoursPerWeek = HoursPerDay * DaysPerWeek

const MinutesPerDay = HoursPerDay * MinutesPerHour
const MinutesPerWeek = HoursPerWeek * MinutesPerHour

const SecondsPerHour = MinutesPerHour * SecondsPerMinute
const SecondsPerDay = HoursPerDay * SecondsPerHour
const SecondsPerWeek = SecondsPerDay * DaysPerWeek

const MillisecondsPerMinute = SecondsPerMinute * MillisecondsPerSecond
const MillisecondsPerHour = MinutesPerHour * MillisecondsPerMinute
const MillisecondsPerDay = HoursPerDay * MillisecondsPerHour
const MillisecondsPerWeek = MillisecondsPerDay * DaysPerWeek

const MicrosecondsPerSecond = MillisecondsPerSecond * MicrosecondsPerMillisecond
const MicrosecondsPerMinute = SecondsPerMinute * MillisecondsPerSecond
const MicrosecondsPerHour = MinutesPerHour * MillisecondsPerMinute
const MicrosecondsPerDay = HoursPerDay * MillisecondsPerHour
const MicrosecondsPerWeek = MicrosecondsPerDay * DaysPerWeek

const NanosecondsPerMillisecond = MicrosecondsPerMillisecond * NanosecondsPerMicrosecond
const NanosecondsPerSecond = MillisecondsPerSecond * NanosecondsPerMillisecond
const NanosecondsPerMinute = SecondsPerMinute * NanosecondsPerSecond
const NanosecondsPerHour = MinutesPerHour * NanosecondsPerMinute
const NanosecondsPerDay = HoursPerDay * NanosecondsPerHour
const NanosecondsPerWeek = NanosecondsPerDay * DaysPerWeek

const Time0 = Time(0)
const Date0 = Date(0)
const DateTime0 = DateTime(0)

const Nanosecond0 = Nanosecond(0)
const Microsecond0 = Nanosecond(0)
const Millisecond0 = Millisecond(0)
const Second0 = Second(0)
const Minute0 = Minute(0)
const Hour0 = Hour(0)
const Day0 = Day(0)
const Week0 = Week(0)
const Month0 = Month(0)
const Quarter0 = Quarter(0)
const Year0 = Year(0)

const RataDie0 = Date(0, 12, 31)
const UnixDate0 = Date(1970, 1, 1)
const UnixTime0 = Time0
const UnixDateTime0 = DateTime(1970,1,1, 0,0,0,0)

const UnixRataDie = Dates.value(UnixDate0)
const Epoch2000RataDie = Dates.value(Date(2000,1,1))
const UnixMilliseconds = Dates.value(UnixDateTime0)
const UnixMicroseconds = UnixMilliseconds * MicrosecondsPerMillisecond
const UnixNanoseconds = Int128(UnixMilliseconds) * NanosecondsPerMillisecond

const Epoch2000Time = Time0
const Epoch2000Date = Date(2000,1,1)
const Epoch2000DateTime = DateTime(2000,1,1, 0,0,0, 0)
const Epoch2000RataDie = Dates.value(Epoch2000Date)
const Epoch2000Milliseconds = Dates.value(Epoch2000)
const Epoch2000Nanoseconds  = Int128(Epoch2000Milliseconds) * NanosecondsPerMilliseconds

