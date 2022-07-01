function utc_delta()
    utctime, localtime = now(UTC), now()
    utcdelta = canonicalize(localtime - utctime).periods
    dys = day(utcdelta)
    hrs = hour(utcdelta) + 24*dys
    mins = minute(utcdelta)
    mins = div(mins + copysign(7, mins), 15) * 15 # nearest 15 mins
    if hrs < 0 || (hrs == 0 && mins < 0)
        delta_sign = "-"
        hrs = abs(hrs)
        mins = abs(mins)
    else
        delta_sign = "+"
    end

    hrs_str = (hrs < 10) ? string(0, hrs) : string(hrs)
    mins_str = (mins < 10) ? string(0, mins) : string(mins)
    delta_str = string(delta_sign, hrs_str, ":", mins_str)
    delta_str_nosep = string(delta_sign, hrs_str, mins_str)
    delta_str, delta_str_nosep, Hour(hrs) + Minute(mins)
end

utc_delta_str, utc_delta_str_nosep, utc_delta_hours_minutes = utc_delta()

const LOCAL_TZ_DELTA_STR = utc_delta_str 
const LOCAL_TZ_DELTA_STR_NOSEP = utc_delta_str_nosep
const LOCAL_TZ_DELTA = utc_delta_hours_minutes

# Timestamp

function timestamp(nd::NanoDate; utc=true, localtime=false, postfix=true, sep="" )
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
          suffix = LOCAL_TZ_DELTA_STR
        else
          suffix = ""
          nd = nd + LOCAL_TZ_DELTA
        end
    else
        suffix = ""
    end

    tstamp = string(nd; sep) * suffix
    tstamp
end


"""
  using BenchmarkTools
  calltime = round(Int, 1e9 * @belapsed ndnow(; sequential=false))
  calltime = floor(Int, 1e9 * @belapsed ndnow(; sequential=true))
"""

UTC0 = NanoDate(today())
LOCAL0 = NanoDate(today())

increment = 0x0000
lastns = UInt64(0)

function reset_timekeeping()
    global UTC0, LOCAL0, increment, lastns
    increment = 0x0000
    lastns    = zero(UInt64)

	utctime, localtime, ns = now(UTC), now(), time_ns()
	utcnd, localnd = NanoDate(utctime), NanoDate(localtime)
	UTC0 = utcnd - Nanosecond(ns)
    LOCAL0 = localnd - Nanosecond(ns)
	nothing
end

function ndnow(; sequential::Bool=true)
    global LOCAL0
	LOCAL0 + ndnow_ns(sequential)
end

function ndnow(::Type{UTC}; sequential::Bool=true)
    global UTC0
	UTC0 + ndnow_ns(sequential)
end

function ndnow_ns(sequential::Bool=true)
    global increment, lastns

    ns = time_ns()
	if sequential
	    if ns === lastns
	       increment += 1
           ns = ns + increment
	    else
	       lastns = ns
	       increment = 0
	    end
	end

    Nanosecond(ns)
end

function ndnow_strict()
    global LOCAL0
	LOCAL0 + ndnow_ns_strict()
end

function ndnow_strict(::Type{UTC})
    global UTC0
	UTC0 + ndnow_ns_strict()
end

function ndnow_ns_strict()
    global increment, lastns

    ns = time_ns()

    if ns > lastns                  # this branch >98%
        lastns = ns
        increment = 0x0000
    elseif ns === lastns            # this branch  <2%
        increment += 0x0001
        ns += increment
    else                            # almost never
        reset_timekeeping()
    end

    Nanosecond(ns)
end


