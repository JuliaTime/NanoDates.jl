# returns the specifier part as a string
Base.String(df::DateFormat) = string(df)[12:end-1]

omit(needle::Nothing, haystack::Nothing) = nothing
omit(needle, haystack::Nothing) = nothing
omit(needle::Nothing, haystack) = haystack

omit(needle::T1, haystack::T2) where {S1<:Signed,S2<:Signed,T1<:AbstractRange{S1},T2<:AbstractRange{S2}} =
    omit(collect(needle), collect(haystack))
omit(needle::T1, haystack::T2) where {T1,S<:Signed,T2<:AbstractRange{S}} = omit(needle, collect(haystack))
omit(needle::T1, haystack::T2) where {T2,S<:Signed,T1<:AbstractRange{S}} = omit(collect(needle), haystack)

omit(needle::T1, haystack::T2) where {N1,N2,S1<:Signed,S2<:Signed,
    T1<:Union{NTuple{N1,S1},Vector{S1}},
    T2<:Union{NTuple{N2,S2},Vector{S2}}} =
    setdiff(haystack, needle)

function omit(needle::T1, haystack::AbstractString) where {T1<:Union{AbstractChar,AbstractString}}
    allidxs = 1:length(haystack)
    idxs = findall(needle, haystack)
    isempty(idxs):haystack:join(haystack[omit(idxs, allidxs)])
end

function omit(needles::T1, haystack::AbstractString) where {T1<:Union{AbstractVector{Int},NTuple{N,Int}}} where {N,T}
    allidxs = 1:length(haystack)
    isempty(needles) ? haystack : join(haystack[omit(needles, allidxs)])
end

function findeach(needle, haystack)
    idxs = findall(needle, haystack)
    n = length(idxs)
    n, idxs
end

function nanodateformat(nd::NanoDate, df::DateFormat; subsecsep::Union{Char,AbstractString}='.')
    dfstr = String(df)
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
absorb(x,y) = string(x)
absorb(x,y,z) = string(x)

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

#=
  findnext(ch::AbstractChar, string::AbstractString, start::Integer)
=#

function findandexpand(nd, str::String)
    chrs = Tuple(first.(split(str, "")))
    letters = map(isletter, chrs)
    nonletters = map(!, letters)
    
     map(ch -> isletter(ch) ? ch2str(nd, ch) : ch, chrs)
     
     
     char2padfn[ch](value(char2period[ch](nd)), char2strlen[ch], '0') : ch, chrs)
    (2022, ' ', 6, ' ', 18, ' ', 12, ' ', 15, ' ', 30, ' ', 123, 123, 123, 789, '-', 456)
    #=
        julia > map(ch -> isletter(ch) ? char2period[ch] : ch, chrs)
        (Year, ' ', Month, ' ', Day, ' ', Hour, ' ', Minute, ' ', Second, ' ', Millisecond, Millisecond, Millisecond, Nanosecond, '-', Microsecond)

        julia > map(ch -> isletter(ch) ? char2period[ch](nd) : ch, chrs)
        (Year(2022), ' ', Month(6), ' ', Day(18), ' ', Hour(12), ' ', Minute(15), ' ', Second(30), ' ', Millisecond(123), Millisecond(123), Millisecond(123), Nanosecond(789), '-', Microsecond(456))

        julia > map(ch -> isletter(ch) ? value(char2period[ch](nd)) : ch, chrs)
        (2022, ' ', 6, ' ', 18, ' ', 12, ' ', 15, ' ', 30, ' ', 123, 123, 123, 789, '-', 456)
        fieldchars = unique(str[letters])

        fieldinfo = [findfield(str, ch) for ch in fieldchars]
        sort!(fieldinfo, lt=(x, y) -> (x.offset < y.offset))
    =#
end
    



#=
# regular expressions for matching dates, times, dates-with-times

"""
    Regular Expressions

MiniMatchers

  match without remembering
  
    *sep* in `date<sep>time` where sep ∈ ('T', ' ', ',')
    
        const MatchDateTimeSep = r"(?:(\s|T|,))"

    *sep* in `year<sep>month`

        const MatchYearMonthSep = r"(?:(\s|-|,))"

    *sep* in `hour<sep>minute`

        const MatchHourMinuteSep = r"(?:(\s|:|-|,|.))"

    *sep* in `second<sep>millisecond`

        const MatchSecondMillisSep = r"(?:(\s|.))"

    *sep* in `millisecond<sep>microsecond`

        const MatchMillisMicrosSep = r"(?:(\s|_|◦|,))"

        "2022-05-04T07:30:45",  "2022-05-04 07:30:45"
    separate_date_from_time = r"(\s|T)(?=\d)"
    Match the character that separates the date-part from the time-part
        where the separator character may be 'T' or may be ' ' (space)
        
    separator bto match either 'T' or ' '
ISO8061_ymdhms matches

    "2022-05-04T07:30:45",  "2022-05-04 07:30:45"
    "2022-05-04T07:30:45",  "2022-05-04 07:30:45"

=#

#=
regular_expressions

# match without remembering
  
const MatchDateTimeSep = r"(?:(\s|T|^|,))"
const MatchYearMonthSep = r"(?:(\s|-|,))"
const MatchHourMinuteSep = r"(?:(\s|:|-|,|.))"
const MatchSecondMillisSep = r"(?:(\s|.))"
const MatchMillisMicrosSep = r"(?:(\s|_|◦|,))"

# match to name

const MatchYear = r"?<year>(\d{4}))"
const MatchYMD = r"((?<year>(\d{4}))(?:(\s|-))(?<month>(\d{1,2}))(?:(\s|-))(?<day>(\d{1,2})))"
const MatchHMS = r"((?<hour>(\d{4}))(?:(\s|:|-))(?<minute>(\d{1,2}))(?:(\s|:|-))(?<second>(\d{1,2})))"
const MatchSubsecs = r"((?<millis>(\d{0,3}))(?:(_|' '))(?<micros>(\d{0,3}))(?:(_|' '))(?<nanos>(\d{0,3})))"

const ISO8061_ymd_HMS = r"\d{4}(.\d{2}){2}(\s|T)(\d{2}.){2}\d{2}"

=#
