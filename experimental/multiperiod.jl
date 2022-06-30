const MultiPeriod = NamedTuple{(:year, :month, :day, :hour, :minute, :second,
        :millisecond, :microsecond, :nanosecond),N Tuple{9,Int64}}
const MultiPeriodYMD = NamedTuple{(:year, :month, :day),NTuple{3,Int64}}
const MultiPeriodHMS = NamedTuple{(:hour, :minute, :second),NTuple{3,Int64}}
const MultiPeriodMMN = NamedTuple{(:millisecond, :microsecond, :nanosecond),NTuple{3,Int64}}

ymd(year::Int64, month::Int64=1, day::In64=1) = MultiPeriodYMD((year, month, day))
hms(hour::Int64=0, minute::Int64=0, second::In64=0) = MultiPeriodHMS((hour, minute, second))
mmn(millisecond::Int64=0, microsecond::Int64=0, nanosecond::Int64=0)

