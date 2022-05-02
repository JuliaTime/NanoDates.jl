#=
    struct wrapped character constants for NanoDate formats
=#


# '⦰' is the reversed empty set 0x29b0
Base.isempty(ch::Char) = ch === EmptyChar

const CapitalT = 'T'      # ISO selected char, separates date from time 
const SmallCapitalT = 'ᴛ' # latin letter small capital T 0x1d1b 
const PunctDot = '.'      # separates fractions of a second, subseconds

const EmptyChar = '⦰'
const SingleSpace = ' '
const Underscore = '_'
const SmallWhiteCircle = '◦'
const SmallWhiteStar = '⭒'

#=
        make a string representation from a NanoDate
=#

Base.string(nd::NanoDate) = nanodate_string(nd)
Base.string(nd::NanoDate, sep::Char) = nanodate_string(nd, sep)

function nanodate_string(nd)
    str = string(nd.datetime)
    micronanos = value(nd.nanosecs)
    micronanos == 0 && return str
    millis = millisecond(nd.datetime)
    if millis == 0 # micronanos != 0
        str *= ".000"
    end
    micros, nanos = divrem(micronanos, NanosecondsPerMicrosecond)
    if nanos == 0 # micros != 0
        str *= lpad(micros, 3, '0')
    elseif micros == 0 # nanos != 0
        str *= lpad(nanos, 6, '0')
    else # micros != 0 && nanos != 0
        str *= lpad(micros, 3, '0')
        str *= lpad(nanos, 3, '0')
    end
    str
end

function nanodate_string(nd::NanoDate, sep::Char)
    str = string(nd.datetime)
    datepart, timepart = split(str, CapitalT)
    nanos = value(nd.nanosecs)
    nanos === 0 && return str
    micros, nanos = fldmod(nanos, 1_000)

    millis = millisecond(nd.datetime)
    if millis === 0
        str = str * ".000"
    end

    if nanos === 0
        padded = sep * lpad(micros, 3, '0')
    elseif micros === 0
        padded = sep * "000" * sep * lpad(nanos, 3, '0')
    else
        padded = sep * lpad(micros, 3, '0') * sep * lpad(nanos, 3, '0')
    end
    str * padded
end

function Dates.format(nd::NanoDate, df::DateFormat=NANODATE_FORMAT; sep::CharString="")
    str = Dates.format(nd.datetime, df)
    nsubsecfields = 0
    lasttoken = df.tokens[end]
    if isa(lasttoken, Dates.DatePart) &&
       typeof(lasttoken).parameters[1] === 's'
        nsubsecfields = lasttoken.width
    end
    nanos = value(nd.nanosecs)
    iszero(nanos) && return str
    cs, ns = divrem(nanos, 1_000)
    millis = millisecond(nd.datetime)
    if nsubsecfields > 1
        str = str * sep * lpad(cs, 3, '0')
        iszero(ns) && return str
        if nsubsecfields > 2
            str = str * sep * lpad(ns, 3, '0')
        end
    end
    str
end

function Time(s::String)
    n = length(s)
    n <= 12 && return Dates.Time(s)
    timefromstring(s)
end

function timefromstring(s::String)
    dotidx = findlast(x -> x == '.', s)
    if isnothing(dotidx) || length(s) - dotidx <= 3
        return parse(Time, s)
    else
        secs, subsecs = split(s, '.')
        secs *= "." * subsecs[1:3]
        subsecs = subsecs[4:end]
        tm = parse(Time, secs)
        isubsecs = Meta.parse("1" * subsecs)
        micros, nanos = divrem(isubsecs, 1_000)
        micros = mod(micros, 1_000)
        return tm + Microsecond(micros) + Nanosecond(nanos)
    end
end
