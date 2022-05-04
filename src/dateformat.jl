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
