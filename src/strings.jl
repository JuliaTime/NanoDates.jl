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

internal_strings(df::DateFormat) = internal_strings(internal_string(df))

function Base.parse(::Type{NanoDate}, str::AbstractString, df::DateFormat)
    str_secsplus, str_subsecs = string.(internal_strings(str))
    df_secsplus, df_subsecs = string.(internal_strings(df))
    secsplus = DateTime(str_secsplus, df_secsplus)
    if isempty(str_subsecs) 
        subsecs = 0
    else
        n = length(str_subsecs)
        dv,rm = divrem(n, 3)
        zeroslen = 3 - (rm == 0 ? 3 : rm)
        str_subsecs = (str_subsecs * "00000000")[1:9]
        subsecs = parse(Int, rpad(parse(Int,str_subsecs), zeroslen, "0"))
    end
    subsec = Nanosecond(subsecs)
    NanoDate(secsplus, subsec)
end

NanoDate(str::String; df=dateformat"yyyy-mm-ddTHH:MM:SS.sss") = parse(NanoDate, str, df)

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
    