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

Base.string(nd::NanoDate; sep::CharString=EmptyChar) =
    sep === EmptyChar ? nanodate_string(nd) : nanodate_string(nd, sep)

Base.string(nd::NanoDate, sep) = string(nd; sep=sep)

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

function nanodate_string(nd::NanoDate, sep::CharString)
    dtm = nd.datetime
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

Dates.format(nd::NanoDate, df::DateFormat=NANODATE_FORMAT;
    sep::CharString=EmptyChar) =
    sep === EmptyChar ? nanodate_format(nd, df) :
    nanodate_format(nd, df, sep)

function nanodate_format(nd, df)
    datetime = nd.datetime
    str = Dates.format(datetime, df)
    value(nd.nanosecs) == 0 && return str

    millis = millisecond(datetime)
    millistr = PunctDot * lpad(millis, 3, '0')
    str = split(str, PunctDot)[1]

    nsubsecfields = 0
    lasttoken = df.tokens[end]
    if isa(lasttoken, Dates.DatePart) &&
       typeof(lasttoken).parameters[1] === 's'
        nsubsecfields = lasttoken.width
    end
    nsubsecfields == 0 && return str
    str = str * millistr
    nsubsecfields == 1 && return str
    nanos = value(nd.nanosecs)
    cs, ns = divrem(nanos, 1_000)
    str = str * lpad(cs, 3, '0')
    nsubsecfields == 2 && return str
    str = str * lpad(ns, 3, '0')
    str
end

function nanodate_format(nd, df, sep)
    datetime = nd.datetime
    str = Dates.format(datetime, df)
    value(nd.nanosecs) == 0 && return str

    millis = millisecond(datetime)
    millistr = PunctDot * lpad(millis, 3, '0')
    str = split(str, PunctDot)[1]

    nsubsecfields = 0
    lasttoken = df.tokens[end]
    if isa(lasttoken, Dates.DatePart) &&
       typeof(lasttoken).parameters[1] === 's'
        nsubsecfields = lasttoken.width
    end
    nsubsecfields == 0 && return str
    str = str * millistr
    nsubsecfields == 1 && return str
    nanos = value(nd.nanosecs)
    cs, ns = divrem(nanos, 1_000)
    str = str * sep * lpad(cs, 3, '0')
    nsubsecfields == 2 && return str
    str = str * sep * lpad(ns, 3, '0')
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

internal_string(df::DateFormat) = string(typeof(df).parameters[1])

function internal_strings(str::AbstractString)
    if occursin('.', str)
        secsplus, subsecs = split(str, '.')
    else
        secsplus = str
        subsecs = ""
    end
    (secsplus, subsecs)
end

function internal_zone(subsecs::AbstractString)
    if isempty(subsecs)
        ("", Hour(0))
    elseif endswith(subsecs, 'Z')
        (subsecs[1:end-1], Hour(0))
    elseif '+' ∈ subsecs || '-' ∈ subsecs
        plus = findlast('+', subsecs)
        minus = findlast('-', subsecs)
        sgn = isnothing(plus) ? -1 : +1
        idx = sgn < 0 ? minus : plus
        digits = subsecs[1:idx-1]
        offset = subsecs[idx+1:end]
        colon = findlast(':', offset)
        if isnothing(colon)
            n = length(offset)
            hr = n > 0 ? offset[1:min(2, n)] : "0"
            mn = n > 2 ? offset[3:end] : "0"
        else
            hr, mn = split(offset, ':')
            if isempty(hr)
                hr = "0"
            end
            if isempty(mn)
                mn = "0"
            end
        end
        hr = Hour(copysign(parse(Int, hr), sgn))
        mn = Minute(copysign(parse(Int, mn), sgn))
        (digits, hr + mn)
    else
        (subsecs, Hour(0))
    end
end

internal_strings(df::DateFormat) = internal_strings(internal_string(df))

function Base.parse(::Type{NanoDate}, str::AbstractString, df::DateFormat)
end

function parts(::Type{NanoDate}, str::AbstractString)
    str_secsplus, str_subsecs = string.(internal_strings(str))
    str_zoneoffset = ""
    if !isempty(str_subsecs)
        if endswith(str_subsecs, "Z")
            str_subsecs = str_subsecs[1:end-1]
            str_zoneoffset = "Z"
        elseif occursin('+', str_subsecs)
            idx = findfirst('+', str_subsecs)
            str_zoneoffset = str_subsecs[idx:end]
            str_subsecs = str_subsecs[1:idx-1]
        elseif occursin('-', str_subsecs)
            idx = findfirst('-', str_subsecs)
            str_zoneoffset = str_subsecs[idx:end]
            str_subsecs = str_subsecs[1:idx-1]
        end
    end
    str_secsplus, str_subsecs, str_zoneoffset
end

function NanoDate(str::AbstractString)
    secsplus, subsecs, zoneoffset = parts(NanoDate, str)
    nd = NanoDate(DateTime(secsplus), Nanosecond(subsecs))
    if !isempty(zoneoffset) && zoneoffset[1] !== 'Z'
        sgn = zoneoffset[1] == '+' ? +1 : -1
        hr = Hour(copysign(parse(Int, zoneoffset[2:3]), sgn))
        mn = Minute(copysign(parse(Int, zoneoffset[end-1:end]), sgn))
        nd = nd + (hr + mn)
    end
    nd
end

NanoDate(str::String, df::DateFormat) = parse(NanoDate, str, df)

function fieldspan(str, chr, n=length(str))
    firstidx = 0
    lastidx  = 0
    idx = findfirst(chr, str)
    if !isnothing(idx)
        firstidx = idx
        lastidx = firstidx
        while lastidx < n
            if str[lastidx + 1] == chr
                lastidx += 1
            else
                break
            end
        end
    end
    firstidx:lastidx
end

const ZeroRange = 0:0

Base.@kwdef struct FieldsSpan
    year::UnitRange{Int} = ZeroRange
    month::UnitRange{Int} = ZeroRange
    day::UnitRange{Int} = ZeroRange
    hour::UnitRange{Int} = ZeroRange
    minute::UnitRange{Int} = ZeroRange
    second::UnitRange{Int} = ZeroRange
    subsec::UnitRange{Int} = ZeroRange
    offset_z::UnitRange{Int} = ZeroRange
    offset_sign::UnitRange{Int} = ZeroRange
    offset_hour::UnitRange{Int} = ZeroRange
    offset_minute::UnitRange{Int} = ZeroRange
end

function fieldspans(df::DateFormat)
    str = String(df)
    n = length(str)
    yr = fieldspan(str, 'y', n)
    mn = fieldspan(str, 'm', n)
    dy = fieldspan(str, 'd', n)
    hr = fieldspan(str, 'H', n)
    mi = fieldspan(str, 'M', n)
    sc = fieldspan(str, 'S', n)
    ss = fieldspan(str, 's', n)
    oz = fieldspan(str, 'Z', n)
    # check for +/-hhmm, +/-hh:mm
    sidx = findlast('+', str)
    if isnothing(sidx)
        sidx = findlast('-', str)
        if !isnothing(sidx)
            hidx = findlast('h', str)
            if isnothing(hidx) || (hidx < sidx)
                sidx = nothing
            end
        end
    end
    if isnothing(sidx)
        os = ZeroRange
        oh = ZeroRange
        om = ZeroRange
    else
        os = sidx:sidx
        str2 = @view(str[sidx+1:end])
        firstidx = findfirst('h', str2)
        if !isnothing(firstidx)
            lastidx = findlast('h', str2)
            oh = (sidx+firstidx):(sidx+lastidx)
        else
            oh = ZeroRange
        end
        firstidx = findfirst('m', str2)
        if !isnothing(firstidx)
            lastidx = findlast('m', str2)
            om = (sidx+firstidx):(sidx+lastidx)
        else
            om = ZeroRange
        end
    end

    FieldsSpan(yr, mn, dy, hr, mi, sc, ss, oz, os, oh, om)
end

@inline strspan(str::AbstractString, span::UnitRange{Int}) = str[span]
@inline strperiod(str::AbstractString, span::UnitRange{Int}, period::Type{<:Period}) =
    iszero(first(span)) ? period(0) : period(strspan(str, span))

function fieldsbyspan(spans::FieldsSpan, str::AbstractString)
    yr = strperiod(str, spans.year, Year)
    mn = strperiod(str, spans.month, Month)
    dy = strperiod(str, spans.day, Day)
    hr = strperiod(str, spans.hour, Hour)
    mi = strperiod(str, spans.minute, Minute)
    sc = strperiod(str, spans.second, Second)
    ss = Dates.value(strperiod(str, spans.subsec, Nanosecond))
    ms,us,ns = tosubsecs(ss)
    oz = !iszero(first(spans.offset_z))
    os = iszero(first(spans.offset_sign)) ? 0 : str[spans.offset_sign] === '+' ? +1 : -1
    oh = strperiod(str, spans.offset_hour, Hour)
    om = strperiod(str, spans.offset_minute, Minute)
    if os < 1
        oh = -oh
        om = -om
    end
    (yr, mn, dy, hr, mi, sc, ms, us, ns, oh, om)
end

function tosubsecs(ss)
    millis = micros = nanos = 0
    if !iszero(ss)
        if ss < 1000
            millis = ss
        elseif ss < 1_000_000
            millis, micros = fldmod(ss, 1_000)
        else
            micros, nanos = fldmod(ss, 1_000)
            millis, micros = fldmod(micros, 1_000)
        end
    end
    Millisecond(millis), Microsecond(micros), Nanosecond(nanos)
end

function separate_offset(df::DateFormat)
    str = String(df)
    if endswith(str, 'Z')
        (str[1:end-1], str[end:end])
    elseif str[end-4:end] == "hh:mm"
        (str[1:end-6], str[end-5:end])
    elseif str[end-3:end] == "hhmm"
        (str[1:end-5], str[end-4:end])
    else
        (str, "")
    end
end

@inline ffirst_date(str) =
    minimum(filter(!isnothing, (findfirst('y', str), findfirst('m', str), findfirst('d', str))))

@inline flast_date(str) =
    maximum(filter(!isnothing, (findlast('y', str), findlast('m', str), findlast('d', str))))

@inline ffirst_hms(str) =
    minimum(filter(!isnothing, (findfirst('H', str), findfirst('M', str), findfirst('S', str))))

@inline flast_hms(str) =
    maximum(filter(!isnothing, (findlast('H', str), findlast('M', str), findlast('S', str))))

function separate_date(dfstr::AbstractString)
    if !('y' ∈ dfstr || 'm' ∈ dfstr || 'd' ∈ dfstr)
        ("", dfstr)
    else
        n = length(dfstr)
        firstidx = ffirst_date(dfstr)
        lastidx  = flast_date(dfstr)
        if firstidx === 1
            if lastidx === n
                (dfstr, "")
            else
                (dfstr[firstidx:lastidx], dfstr[lastidx+1:end])
            end
        elseif lastidx === n
            (dfstr[firstidx:lastidx], dfstr[1:firstidx-1])
        else
            (dfstr[firstidx:lastidx], dfstr[1:firstidx-1]*' '*dfstr[lastidx+1:end])
        end
    end
end

function separate_subsecs(dfstr::AbstractString)
    if dfstr === "."
        return ("", "")
    end
    dotidx = findfirst('.', dfstr)
    if !isnothing(dotidx)
        if endswith(dfstr, '.')
            dfstr = dfstr[1:end-1]
        elseif startswith(dfstr, '.')
            dfstr = dfstr[2:end]
        else
            dfstr = dfstr[1:dotidx-1] * dfstr[dotidx+1:end]
        end
    end
    firstidx = findfirst('s', dfstr)
    if isnothing(firstidx)
        ("", dfstr)
    else
        lastidx = findlast('s', dfstr)
        n = length(dfstr)
        if firstidx === 1
            if lastidx === n
                (dfstr, "")
            else
                (dfstr[firstidx:lastidx], dfstr[lastidx+1:end])
            end
        elseif lastidx === n
            (dfstr[firstidx:lastidx], dfstr[1:firstidx-1])
        else
            (dfstr[firstidx:lastidx], dfstr[1:firstidx-1]*' '*dfstr[lastidx+1:end])
        end
    end
end

function separate_hms(dfstr::AbstractString)
    if !('H' ∈ dfstr || 'M' ∈ dfstr || 'S' ∈ dfstr)
        ("", dfstr)
    else
        n = length(dfstr)
        firstidx = ffirst_hms(dfstr)
        lastidx  = flast_hms(dfstr)
        if firstidx === 1
            if lastidx === n
                (dfstr, "")
            else
                (dfstr[firstidx:lastidx], dfstr[lastidx+1:end])
            end
        elseif lastidx === n
            (dfstr[firstidx:lastidx], dfstr[1:firstidx-1])
        else
            (dfstr[firstidx:lastidx], dfstr[1:firstidx-1]*' '*dfstr[lastidx+1:end])
        end
    end
end

#=
ref: https://github.com/Kotlin/kotlinx-datetime/issues/139

fun Instant.Companion.parseWithBasicOffset(string: String): Instant {
    var lastDigit = string.length
    while (lastDigit > 0 && string[lastDigit - 1].isDigit()) { --lastDigit }
    val digits = string.length - lastDigit // how many digits are there at the end of the string
    if (digits <= 2)
        return parse(string) // no issue in any case
    var newString = string.substring(0, lastDigit + 2)
    lastDigit += 2
    while (lastDigit < string.length) {
        newString += ":" + string.substring(lastDigit, lastDigit + 2)
        lastDigit += 2
    }
    return parse(newString)
}
=#
    