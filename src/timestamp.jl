val(x::CompoundPeriod) = isempty(x) ? 0 : canonicalize(x)
val(x) = isempty(x) ? 0 : value(x)



function utc_delta()
    utctime, localtime = now(UTC), now()
    i = 6
    while (minute(utctime)  != minute(localtime)) && i > 0
        utctime, localtime = now(UTC), now()
        i -= 1
    end
    delta_time = canonicalize((Hour(localtime) + Minute(localtime)) - (Hour(utctime) + Minute(utctime)))
    delta_hours = Hour(delta_time)
    delta_minutes = Minute(delta_time)
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
    delta_time_str
end

const LOCAL_TZ_DELTA = utc_delta()

function timestamp(nd::NanoDate; sep="", utctime=true, localtime=false, postfix=true)
    if localtime == true
        utctime = false
        postfix = true
    elseif postfix == true
        utctime = true
    else
        utctime = false
    end

    if utctime
        postfix = 'Z'
    elseif localtime
        postfix = LOCAL_TZ_DELTA
    else
        postfix = ""
    end

    tstamp = string(nd; sep) * postfix
    tstamp
end


