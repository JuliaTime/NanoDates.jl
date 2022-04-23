function Base.string(nd::NanoDate; sep::Char='∅')
    if sep === '∅'
        nanodate_string(nd)
    else
        nanodate_string(nd, sep)
    end
end

function nanodate_string(nd)
    str = string(nd.datetime)
    nanos = value(nd.nanosecs)
    if nanos === 0
        padded = ""
    elseif nanos % 1_000 !== 0
        padded = lpad(nanos, 6, '0')
    else
        padded = lpad(div(nanos, 1_000), 3, '0')
    end
    str * padded
end

function nanodate_string(nd, sep)
    str = string(nd.datetime)
    
    nanos = value(nd.nanosecs)
    nanos === 0 && return str
    micros, nanos = fldmod(nanos, 1_000)

    millis = millisecond(nd.datetime)
    if millis === 0 str = str * ".000" end

    if nanos === 0
        padded = sep * lpad(micros, 3, '0')
    elseif micros === 0
        padded = sep * "000" * sep * lpad(nanos, 3, '0')
    else
        padded = sep * lpad(micros, 3, '0') * sep * lpad(nanos, 3, '0')
    end
    str * padded
end

