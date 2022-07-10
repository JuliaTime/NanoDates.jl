
# TODO: handle ±hh:mm +hh:mm, -hhmm offsets in dateformat


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

Dates.format(nd::NanoDate, df::DateFormat=NANODATE_FORMAT; sep::CharString=EmptyChar) =
    sep === EmptyChar ? nanodate_format(nd, df) : nanodate_format(nd, df, sep)

@inline lpad2(n) = lpad(n, 2, '0')
@inline lpad3(n) = lpad(n, 3, '0')
@inline lpad4(n) = lpad(n, 2, '0')
@inline lpad9(n) = lpad(n, 9, '0')

lazystring2charvec(str::AbstractString) = (str[i] for i in eachindex(str))
string2charvec(str::AbstractString) = collect(lazystring2charvec(str))
charvec2string(chrs::AbstractVector{Char}) = foldl(*, chrs; init = "")

function nanodate_format(nd, df)
    nooffset(df)
    indices = indexperiods(df)
    dfstr = String(df)
    chrs = string2charvec(dfstr)
    indices = NamedTuple{(:yr, :mn, :dy, :hr, :mi, :sc, :ss)}(indices) # omit offset field
    syms = keys(indices)

    yr = lpad4(year(nd))
    mn = lpad2(month(nd))
    dy = lpad2(day(nd))
    hr = lpad2(hour(nd))
    mi = lpad2(minute(nd))
    sc = lpad2(second(nd))
    ms = lpad3(millisecond(nd))
    μs = lpad3(microsecond(nd))
    ns = lpad3(nanosecond(nd))
    ss = ms * μs * ns

    if :yr in syms && !iszero(indices.yr.start)
        chrs[indices.yr] .= string2charvec(yr)
    end
    if :mn in syms && !iszero(indices.mn.start)
        chrs[indices.mn] .= string2charvec(mn)
    end
    if :dy in syms && !iszero(indices.dy.start)
        chrs[indices.dy] .= string2charvec(dy)
    end
    if :hr in syms && !iszero(indices.hr.start)
        chrs[indices.hr] .= string2charvec(hr)
    end
    if :mi in syms && !iszero(indices.mi.start)
        chrs[indices.mi] .= string2charvec(mi)
    end
    if :sc in syms && !iszero(indices.sc.start)
        chrs[indices.sc] .= string2charvec(sc)
    end
    

    if :ss in syms && !iszero(indices.ss.start)
        chrs[indices.ss] .= string2charvec(ss[1:length(indices.ss)])
    end
    if :ms in syms && !iszero(indices.ms.start)
        chrs[indices.ms] .= string2charvec(ms)
    end
    if :μs in syms && !iszero(indices.μs.start)
        chrs[indices.μs] .= string2charvec(μs)
    end
    if :ns in syms && !iszero(indices.ns.start)
        chrs[indices.ns] .= string2charvec(ns)
    end

    if :ms in syms
        chrs[indices.ms] .= string2charvec(ms)
    end
    if :μs in syms
        chrs[indices.μs] .= string2charvec(μs)
    end
    if :ns in syms
        chrs[indices.ns] .= string2charvec(ns)
    end

    nss = length(indices.ss)
    ss = ss[1:nss]
    chrs[indices.ss] = string2charvec(ss)

    charvec2string(chrs)
end

#=

    datetime = nd.datetime
    millis = value(Millisecond(datetime))
    micros, nanos = fldmod(value(nd.nanosecs), 1_000)
    subsec_value = millis * 1_000_000 + micros * 1_000 + nanos
    subsec_str = lpad(subsec_value, 9, '0')
    supersec = datetime - Millisecond(datetime)
    
    dfstr = String(df)
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
=#

function nanodate_format(nd, df, sep)
    nooffset(df)
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

nooffset(df::DateFormat) = nooffset(String(df))
function nooffset(str::AbstractString)
    if occursin('+', str)
        throw(ArgumentError("utc offsets are not supported in format(), use timestamp()"))
    end
end


separate_offset(df::DateFormat) = separate_offset(String(df))

function separate_offset(str::AbstractString)
    if isempty(str) || isdigit(str[end])
        ("", "")
    elseif endswith(str, 'Z')
        ("", "Z")
    elseif str[end-4:end] == "hh:mm"
        (str[end-5], "hh:mm")
    elseif str[end-3:end] == "hhmm"
        (str[end-4], "hhmm")
    else
        throw(ArgumentError("offset in $(str) not recognized"))
    end
end


#Base.UnitRange(start::Nothing, stop::Nothing) = 0:0
Base.UnitRange(start::Nothing, stop::Nothing) = throw(ErrorException("0:0"))

const NTPeriods9 = NamedTuple{(:yr, :mn, :dy, :hr, :mi, :sc, :ss, :us, :ns),NTuple{9,UnitRange{Int64}}}
const NTPeriods7 = NamedTuple{(:yr, :mn, :dy, :hr, :mi, :sc, :ss),NTuple{7,UnitRange{Int64}}}

function tooffset(str::AbstractString)
    hr = 0
    mn = 0
    sgn = 1
    if !isempty(str) && length(str) > 3
        sgn = str[1] == '+' ? 1 : -1
        hr = Meta.parse(str[2:3])
        mn = Meta.parse(str[end-1:end])
    end
    copysign(hr, sgn), copysign(mn, sgn)
end

tosubsecs(ss::AbstractString) = tosubsecs(Meta.parse(rpad(ss, 9, '0')))

function tosubsecs(ss::Integer)
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
    millis, micros, nanos
end

function NanoDate(str::AbstractString, df::DateFormat=ISONanoDateFormat; localtime=false)
    indices = indexperiods(df)
    if maximum(last.(Tuple(indices))) != length(str)
        if df !== ISONanoDateFormat
            throw(ArgumentError("$(str) does not match dateformat"))
        else
            return simpleparse(indices, str)
        end
    end
    parts = getparts(indices, str)
    subsecs = tosubsecs(parts.ss)
    offsets = tooffset(parts.offset)
    periods = (ntuple(i -> parse(Int, parts[i]), Val(6))..., subsecs...)
    result = NanoDate(periods...)
    if localtime
        result += (Hour(offsets[1]) + Minute(offsets[2]))
    end
    result
end

function simpleparse(indices, str::AbstractString)
    if occursin('.', str)
        supersec, subsec = strip.(split(str, '.'))
        if !occursin('T', supersec) && occursin(' ', supersec)
            supersec = join(split(supersec, ' '), 'T')
        end
        subsec = filter(isdigit, subsec)
        if !endswith(subsec, 'Z') && !occursin('+', subsec) && !occursin('-', subsec)
            subsec = rpad(subsec, 9, '0')
            subsecs = tosubsecs(Meta.parse(subsec))
            subseconds = Millisecond(subsecs[1]) + Microsecond(subsecs[2]) + Nanosecond(subsecs[3])
            return NanoDate(DateTime(supersec)) + subseconds
        else
            throw(ArgumentError("$(str) needs its own dateformat."))
        end
    else # no '.', no subseconds
        if !occursin('T', str) && occursin(' ', str)
            supersec = join(split(str, ' '), 'T')
            try
                return NanoDate(DateTime(supersec))
            catch
                throw(ArgumentError("$(str) needs its own dateformat."))
            end
        else
            try
                return NanoDate(DateTime(str))
            catch
                throw(ArgumentError("$(str) needs its own dateformat."))
            end
        end
    end
end

getparts(df::DateFormat, str::AbstractString) =
    getparts(indexperiods(df), str)

getparts(indices::NamedTuple{T,NTuple{N,UnitRange{Int}}}, str::AbstractString) where {N,T} =
    map(x -> getpart(x, str), indices)

@inline function getpart(r::UnitRange, str)
    iszero(r.start) && return "0"
    str[r]
end

indexperiods(df::DateFormat) =
    indexperiods(String(df))

function indexperiods(dfstr::String)
    str = strip(dfstr)
    yr = indexfirstlast('y', str)
    mn = indexfirstnext('m', str)
    dy = indexfirstlast('d', str)
    hr = indexfirstnext('H', str)
    mi = indexfirstnext('M', str)
    sc = indexfirstnext('S', str)
    ss = indexfirstlast('s', str)
    offset = indexoffset(dfstr)
    (; yr, mn, dy, hr, mi, sc, ss, offset)
end

function indexoffset(str::AbstractString)
    n = length(str)
    if endswith(str, 'Z')
        offset = n:n
    elseif occursin('+', str) || occursin('±', str)
        found = findlast('+', str)
        if isnothing(found)
            found = findlast('-', str)
        end
        offset = found:n
    else
        offset = 0:0
    end
    offset
end

function indexfirstlast(needle, haystack)
    indices = findfirstlast(needle, haystack)
    UnitRange(indices...)
end

function indexfirstnext(needle, haystack)
    idx1 = findfirst(needle, haystack)
    if needle == haystack[idx1+1]
        idx2 = idx1 + 1
    else
        idx2 = idx1
    end
    UnitRange(idx1, idx2)
end

findfirstlast(needles, haystack) =
    (findfirst(needles, haystack), findlast(needles, haystack))

function Base.findfirst(needles::Tuple, haystack)
    indices = filter(!isnothing, findfirst.(needles, haystack))
    if !isempty(indices)
        minimum(indices)
    else
        nothing
    end
end

function Base.findlast(needles::Tuple, haystack)
    indices = filter(!isnothing, findlast.(needles, haystack))
    if !isempty(indices)
        maximum(indices)
    else
        nothing
    end
end

