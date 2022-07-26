const ISONanoDateFormat = dateformat"yyyy-mm-ddTHH:MM:SS.sssssssss"
Dates.default_format(::Type{NanoDate}) = ISONanoDateFormat

NanoDate(nd::NanoDate, df::DateFormat) = format(nd, df)

# get the specifier part of a DateFormat as a string
# restricts the specifier to 9 subsecond digits
function safestring(df::DateFormat)
    str1 = string(df)[12:end-1]
    str2 = ""
    sepidx = findlast('.', str1)
    isnothing(sepidx) && return str1
    
    if endswith(str1, "Z")
        str1 = str1[1:end-1]
        str2 = "Z"
    elseif endswith(str1, "m") # "±hh:mm" or "±hhmm"
        pmidx = findlast('h', str1)
        if isnothing(pmidx) || pmidx == 1 || (str1[pmidx-1] != '+' || str1[pmidx-1] != '-')
            return str1
        else
            pmidx -= 1
            str1 = str1[1:pmidx-1]
            str2 = str1[pmidx:end]
        end
    end
    
    sidxlast = findlast('s', str1)
    sidxmax  = sepidx + 9
    sidxlast = min(sidxlast, sidxmax)
    str1[begin:sidxlast] * str2
end

omit(needle::Nothing, haystack::Nothing) = nothing
omit(needle, haystack::Nothing) = nothing
omit(needle::Nothing, haystack) = haystack
omit(needle::AbstractRange, haystack::Nothing) = nothing
omit(needle::Nothing, haystack::AbstractRange) = nothing

omit(needle::AbstractRange, haystack::AbstractRange) =
    omit(collect(needle), collect(haystack))
omit(needle::AbstractRange, haystack::T) where {T} =
    omit(collect(needle), haystack)
omit(needle::T, hahystack::AbstractRange) where {T} =
    omit(needle, collect(haystack))

omit(needle::AbstractRange, haystack::AbstractString) =
    omit(collect(needle), haystack)

omit(needle::AbstractVector, haystack::AbstractRange ) =
    omit(haystack, needle)

omit(needle::Tuple, haystack::Tuple) = setdiff(haystack, needle)
omit(needle::Vector, haystack::Vector) = setdiff(haystack, needle)
omit(needle::Tuple, haystack::Vector) = setdiff(haystack, [needle...])
omit(needle::Vector, haystack::Tuple) = setdiff([haystack...], needle)

function omit(needle::AbstractString, haystack::AbstractString)
    allidxs = 1:length(haystack)
    idxs = findall(needle, haystack)
    isempty(idxs):haystack:join(haystack[omit(idxs, allidxs)])
end

omit(needle::AbstractChar, haystack::AbstractString) = omit(string(needle), haystack)


function omit(needles::Union{Vector,Tuple}, haystack::AbstractString)
    allidxs = 1:length(haystack)
    isempty(needles) ? haystack : join(haystack[omit(needles, allidxs)])
end

function findeach(needle, haystack)
    idxs = findall(needle, haystack)
    n = length(idxs)
    n, idxs
end

function nanodateformat(nd::NanoDate, df::DateFormat; subsecsep::Union{Char,AbstractString}='.')
    dfstr = safestring(df)
    scount, sindices = findeach('s', dfstr)
    idxsubsecsep = subsecsep == "" ? nothing : findlast(subsecsep, dfstr)
    if !isnothing(idxsubsecsep)
        push!(sindices, idxsubsecsep)
    end

    dfstr_without_subsecs = isempty(sindices) ? dfstr : strip(omit(sindices, dfstr))
    df_without_subsecs = isempty(sindices) ? df : Dates.DateFormat(dfstr_without_subsecs)
    dtm = DateTime(nd)
    dtm_without_subsecs = dtm - Millisecond(dtm)
    result = Dates.format(dtm_without_subsecs, df_without_subsecs)

    nanoseconds = (value(Millisecond(dtm)) * 1_000_000) + value(nanosecs(nd))
    micros, nanos = fldmod(nanoseconds, 1_000)
    millis, micros = fldmod(micros, 1_000)

    millisec = scount < 1 ? "" : lpad(millis, 3, '0')
    microsec = scount < 2 ? "" : lpad(micros, 3, '0')
    nanosec = scount < 3 ? "" : lpad(nanos, 3, '0')

    subsec = millisec * microsec * nanosec

    result * subsecsep * subsec
end

# >> given a string with templatized fields for date periods and time periods
# >> extract each field's covering indices and use them to produce a formatted timestamp

SubSecond(nd::NanoDate) = (mllisecond(nd) + Int128(1000) * (microsecond(nd) * Int128(1000) + nanosecond(nd)))
subsecond(nd::NanoDate) = value(SubSecond(nd))

TzZ(nd::NanoDate) = nothing
Tzz(nd::NanoDate) = nothing
Tzpm(nd::NanoDate) = nothing
Tzmp(nd::NanoDate) = nothing
TzZ(str::AbstractString) = str * 'Z'
Tzz(str::AbstractString) = str * 'Z'
Tzpm(str::AbstractString) = str * "pm"
Tzmp(str::AbstractString) = str * "mp"

absorb(x) = string(x)
absorb(x, y) = string(x)
absorb(x, y, z) = string(x)

char2period = IdDict(zip(
    ('Y', 'y', 'm', 'd', 'H', 'M', 'S', 's', 'c', 'n', 'f', 'Z', 'z', '±', '∓'),
    (Year, Year, Month, Day, Hour, Minute, Second, Millisecond, Microsecond, Nanosecond, SubSecond, TzZ, Tzz, Tzpm, Tzmp)
));

char2count = IdDict(zip(
    ('Y', 'y', 'm', 'd', 'H', 'M', 'S', 's', 'c', 'n', 'f', 'Z', 'z', '±', '∓'),
    (year, year, month, day, hour, minute, second, millisecond, microsecond, nanosecond, subsecond, TzZ, Tzz, Tzpm, Tzmp)
));

char2strlen = IdDict(zip(
    ('Y', 'y', 'm', 'd', 'H', 'M', 'S', 's', 'c', 'n', 'f', 'Z', 'z', '±', '∓'),
    (4, 4, 2, 2, 2, 2, 2, 3, 3, 3, 9, 1, 1, 5, 4)
));

char2padfn = IdDict(zip(
    ('Y', 'y', 'm', 'd', 'H', 'M', 'S', 's', 'c', 'n', 'f', 'Z', 'z', '±', '∓'),
    (absorb, absorb, lpad, lpad, lpad, rpad, rpad, rpad, rpad, rpad, rpad, absorb, absorb, rpad, rpad)
));


function findfield(str::String, chr::Char)
    field_firstidx = findfirst(chr, str)
    typ = char2period[chr]
    (period=typ, offset=field_firstidx)
end

function findfields(str::String)
    fieldchars = filter(isletter, unique(first.(split(str, ""))))
    fieldinfo = [findfield(str, ch) for ch in fieldchars]
    sort!(fieldinfo, lt=(x, y) -> (x.offset < y.offset))
end

@inline function ch2str(nd::NanoDate, ch::Char)
    ch_pad = char2padfn[ch]
    ch_strlen = char2strlen[ch]
    nunits = char2count[ch](nd)
    ch_pad(nd, nunits, '0')
end

function remap_subsecs(str::AbstractString)
    strlen = length(str)
    chrs = first.(split(str, ""))

    s1 = findfirst('s', str)
    s2 = isnothing(s1) ? nothing : findnext('s', str, s1 + 1)
    s3 = isnothing(s2) ? nothing : findnext('s', str, s2 + 1)
    mxidx = s1
    if !isnothing(s2)
        chrs[s2] = 'c'
        mxidx = s2
        if isnothing(s3)
            chrs[s3] = 'n'
            mxidx = s3
        end
    end
    excess = []
    mxidx += 1
    while mxidx <= strlen
        sidx = findnext('s', str, mxidx)
        if !isnothing(sidx)
            push!(excess, sidx)
        end
        mxidx += 1
    end

    if !isempty(excess)
        newchrs = Vector{Char}(uninit, length(chrs) - length(excess))
        newidx = 1
        for i in eachindex(chrs)
            if !(i ∈ excess)
                newchrs[newidx] = chrs[i]
                newidx += 1
            end
        end
    else
        newchrs = @view(chrs[:])
    end

    newchrs
end

#=
  findnext(ch::AbstractChar, string::AbstractString, start::Integer)
=#

function findandexpand(nd::NanoDate, str::AbstractString)
    newstr = remapsubsecs(str)
    chrs = Tuple(first.(split(newstr, "")))
    strs = map(ch -> isletter(ch) ? ch2str(nd, ch) : string(ch), chrs)
    join(strs)
end

