

#### External Conversions

nanodate2rata(nd::NanoDate) = datetime2rata(nd.datetime)

rata2nanodate(rata::Integer) = NanoDate(rata2datetime(rata))

function nanodate2unix(nd::NanoDate)
    millis = (value(nd) - Dates.UNIXEPOCH)
    nanos  = (millis * NanosecondsPerMillisecond) + nd.nanosecs
    nanos / NanosecondsPerMillisecond
end

function unix2nanodate(x)
    nanos = x * NanosecondsPerMillisecond
    millis, nanos = fldmod(nanos, NanosecondsPerMicrosecond)
    NanoDate(DateTime(Dates.UTM(millis)), nanos)
end


julian2nanodate(x) = NanoDate(julian2datetime(x))

nanodate2julian(nd::NanoDate) = datetime2julian(DateTime(nd))