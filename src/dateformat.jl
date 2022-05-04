# returns the specifier part as a string
Base.String(df::DateFormat) = string(df)[12:end-1]

function nanodateformat(nd::NanoDate, df::DateFormat)
    dfstr = String(df)
    if !occursin('.', dfstr)
        datetime = DateTime(nd)
        datetime -= Millisecond(datetime)
        NanoDate(DateTime(datetime, df))
    else
        datetime_string, subsecs_string = split(dfstr, '.')
        datetime = DateTime(nd)
        datetime -= Millisecond(datetime)
        dtm = DateTime(datetime, DateFormat(datetime_string))
        tm = Time(nd - datetime, DateFormat(subsecs_string))
        NanoDate(dtm, tm)
    end
end

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

"""regular_expressions

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
