module Timekeep

export utcinit, localinit, ndnow

using Dates, NanoDates

utc0::NanoDate = NanoDate(today())
local0::NanoDate = NanoDate(today())

increment::UInt16 = 0x0000
lowbits::UInt16 = 0x0000

function utcinit()
    global utc0, increment, lowbits
    increment = 0x0000
    lowdigits = 0x0000

	dtm,  ns = now(UTC), time_ns()
	ndtm = NanoDate(dtm)
	ns128 = ns % Int128
	nano128 = Nanosecond(ns128)
	nd0 = ndtm - nano128
	utc0 = nd0
	nothing
end

function localinit()
    global local0, increment, lowbits
    increment = 0x0000
    lowbits = 0x0000

	dtm,  ns = now(), time_ns()
	ndtm = NanoDate(dtm)
	ns128 = ns % Int128
	nano128 = Nanosecond(ns128)
	nd0 = ndtm - nano128
	local0 = nd0
	nothing
end

function ndnow(::Type{UTC}; sequential::Bool=true)
    global utc0, increment, lowbits
	ns = time_ns()

	ns128 = ns % Int128
	if timestamp
		nslowbits = ns & 0x000000000000000f
	    if lowbits == nslowbits
	       increment += 1
	    else
	       lowbits = nslowbits
	       increment = 0
	    end
	end

	nano128 = Nanosecond(ns128 + increment)
	utc0 + nano128
end

function ndnow(; sequential::Bool=true)
    global local0, increment, lowbits
	ns = time_ns()

	ns128 = ns % Int128
	if timestamp
		nslowbits = ns & 0x0000000000000007
	    if lowbits == nslowbits
	       increment += 1
	    else
	       lowbits = nslowbits
	       increment = 0
	    end
	end

	nano128 = Nanosecond(ns128 + increment)
	local0 + nano128
end

end


val(x::CompoundPeriod) = isempty(x) ? 0 : canonicalize(x)
val(x) = isempty(x) ? 0 : value(x)

function utc_delta()
    utctime, localtime = now(UTC), now()
    if minute(utctime)
    delta_time = canonicalize(localtime - utctime)
    delta_hours = Hour(day(delta_time)*24 + hour(delta_time))
    delta_minutes = minute(delta_time)
    i = 6
    while (minute(utctime)  != minute(localtime)) && i > 0
        utctime, localtime = now(UTC), now()
        i -= 1
    end
    delta_time = canonicalize((Hour(localtime) + Minute(localtime)) - (Hour(utctime) + Minute(utctime)))
    delta_hours = Hour(delta_time)
    delta_minutes = Minute(delta_time)
    delta_hour_value = value(delta_hours)
    delta_minute_value = value(delta_minutes)
    delta_sign = '+'
    if value(delta_hours) < 0
        delta_sign = '-'
    end
    delta_hour_str = string(abs(value(delta_hours)))
    if abs(delta_hour_value) < 10
       delta_hour_str = "0" * delta_hour_str
    end
    delta_minute_str = string(abs(value(delta_minutes)))
    if length(delta_minute_str) < 2
        delta_minute_str = "0" * delta_minute_str
    end
    delta_time_str = delta_sign * delta_hour_str * ":" * delta_minute_str
    delta_time_nosep_str = delta_sign * delta_hour_str * delta_minute_str
    delta_time_str, delta_time_nosep_str, (delta_hours, delta_minutes)
end

function utc_delta()
    utctime, localtime = now(UTC), now()
    i = 6
    while (minute(utctime)  != minute(localtime)) && i > 0
        utctime, localtime = now(UTC), now()
        i -= 1
    end
    delta_time = canonicalize((Hour(localtime) + Minute(localtime)) - (Hour(utctime) + Minute(utctime)))
    delta_hours = Hour(delta_time)
    delta_hour_value = value(delta_hours)
    delta_minutes = Minute(delta_time)
    delta_minute_value = value(delta_minutes)
    delta_sign = '+'
    if value(delta_hours) < 0
        delta_sign = '-'
    end
    delta_hour_str = string(abs(value(delta_hours)))
    if abs(delta_hour_value) < 10
       delta_hour_str = "0" * delta_hour_str
    end
    delta_minute_str = string(abs(value(delta_minutes)))
    if length(delta_minute_str) < 2
        delta_minute_str = "0" * delta_minute_str
    end
    delta_time_str = delta_sign * delta_hour_str * ":" * delta_minute_str
    delta_time_nosep_str = delta_sign * delta_hour_str * delta_minute_str
    delta_time_str, delta_time_nosep_str, (delta_hours, delta_minutes)
end

utc_delta_str, utc_delta_hours_minutes = utc_delta()
const LOCAL_TZ_DELTA = utc_delta_str 
const LOCAL_TZ_DELTA_HOURS = utc_delta_hours_minutes[1]
const LOCAL_TZ_DELTA_MINUTES = utc_delta_hours_minutes[2]

function timestamp(nd::NanoDate; sep="", utc=true, localtime=false, postfix=true)
    if localtime == true
        utc = false
    elseif utc == true
        localtime = false
    else
        utc = false
        localtime = true
        postfix = false
    end

    if utc && postfix
        suffix = "Z"
    elseif localtime
        if postfix
          suffix = LOCAL_TZ_DELTA
        else
          suffix = ""
          nd = nd + (LOCAL_TZ_DELTA_HOURS + LOCAL_TZ_DELTA_MINUTES)
        end
    else
        suffix = ""
    end

    tstamp = string(nd; sep) * suffix
    tstamp
end


