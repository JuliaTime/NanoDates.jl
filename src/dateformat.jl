# returns the specifier part as a string
Base.String(df::DateFormat) = string(df)[12:end-1]

omit(needle::Nothing, haystack::Nothing) = nothing
omit(needle, haystack::Nothing) = nothing
omit(needle::Nothing, haystack) = haystack

omit(needle::T1, haystack::T2) where {S1<:Signed, S2<:Signed, T1<:AbstractRange{S1},T2<:AbstractRange{S2}} =
    omit(collect(needle), collect(haystack))
omit(needle::T1, haystack::T2) where {T1,S<:Signed,T2<:AbstractRange{S}} = omit(needle, collect(haystack))
omit(needle::T1, haystack::T2) where {T2,S<:Signed,T1<:AbstractRange{S}} = omit(collect(needle), haystack)

omit(needle::T1, haystack::T2) where {N1,N2,S1<:Signed, S2<:Signed, 
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
