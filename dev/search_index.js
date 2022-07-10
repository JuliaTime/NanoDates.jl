var documenterSearchIndex = {"docs":
[{"location":"use/timestamps/#Timestamps","page":"Timestamps","title":"Timestamps","text":"","category":"section"},{"location":"use/timestamps/#NanoDates-supports-various-timestamp-formats.","page":"Timestamps","title":"NanoDates supports various timestamp formats.","text":"","category":"section"},{"location":"use/timestamps/","page":"Timestamps","title":"Timestamps","text":"","category":"page"},{"location":"use/timestamps/#ISO8061-UTC-timestamp-formats-(the-default)","page":"Timestamps","title":"ISO8061 UTC timestamp formats (the default)","text":"","category":"section"},{"location":"use/timestamps/","page":"Timestamps","title":"Timestamps","text":"timestamp method(nd::NanoDate)\n2022-05-24T10:43:22Z timestamp(floor(nd, Second); utc=true)\n2022-05-24T10:43:22.350Z timestamp(floor(nd, Millisecond); utc=true)\n2022-05-24T10:43:22.350789Z timestamp(floor(nd, Microsecond); utc=true)\n2022-05-24T10:43:22.350789123Z timestamp(floor(nd, Nanosecond); utc=true)","category":"page"},{"location":"use/timestamps/#ISO8061-local-timestamp-formats","page":"Timestamps","title":"ISO8061 local timestamp formats","text":"","category":"section"},{"location":"use/timestamps/","page":"Timestamps","title":"Timestamps","text":"timestamp method(nd::NanoDate)\n2022-05-24T10:43:22-04:00 timestamp(floor(nd, Second); localtime=true)\n2022-05-24T10:43:22.350-04:00 timestamp(floor(nd, Millisecond); localtime=true)\n2022-05-24T10:43:22.350789-04:00 timestamp(floor(nd, Microsecond); localtime=true)\n2022-05-24T10:43:22.350789123-04:00 timestamp(floor(nd, Nanosecond); localtime=true)","category":"page"},{"location":"use/timestamps/#variant-UTC-timestamp-(omits-the-Z)","page":"Timestamps","title":"variant UTC timestamp (omits the Z)","text":"","category":"section"},{"location":"use/timestamps/","page":"Timestamps","title":"Timestamps","text":"timestamp method(nd::NanoDate)\n2022-05-24T10:43:22 timestamp(floor(nd, Second); utc=true, postfix=false)\n2022-05-24T10:43:22.350 timestamp(floor(nd, Millisecond); utc=true, postfix=false)\n2022-05-24T10:43:22.350789 timestamp(floor(nd, Microsecond); utc=true, postfix=false)\n2022-05-24T10:43:22.350789123 timestamp(floor(nd, Nanosecond); utc=true, postfix=false)","category":"page"},{"location":"use/timestamps/#variant-local-timestamp-(adjusts-for-offset)","page":"Timestamps","title":"variant local timestamp (adjusts for offset)","text":"","category":"section"},{"location":"use/timestamps/","page":"Timestamps","title":"Timestamps","text":"timestamp method(nd::NanoDate)\n2022-05-24T06:43:22 timestamp(floor(nd, Second); localtime=true, postfix=false)\n2022-05-24T06:43:22.350 timestamp(floor(nd, Millisecond); localtime=true, postfix=false)\n2022-05-24T06:43:22.350789 timestamp(floor(nd, Microsecond); localtime=true, postfix=false)\n2022-05-24T06:43:22.350789123 timestamp(floor(nd, Nanosecond); localtime=true, postfix=false)","category":"page"},{"location":"use/timestamps/#timestamp-formats-where-no-zone-is-specified","page":"Timestamps","title":"timestamp formats where no zone is specified","text":"","category":"section"},{"location":"use/timestamps/","page":"Timestamps","title":"Timestamps","text":"timestamp method(nd::NanoDate)\n2022-05-24T10:43:22 timestamp(floor(nd, Second))\n2022-05-24T10:43:22.350 timestamp(floor(nd, Millisecond))\n2022-05-24T10:43:22.350789 timestamp(floor(nd, Microsecond))\n2022-05-24T10:43:22.350789123 timestamp(nd)","category":"page"},{"location":"use/timestamps/#timestamps-with-subsecond-separators-(other-options-still-available)","page":"Timestamps","title":"timestamps with subsecond separators (other options still available)","text":"","category":"section"},{"location":"use/timestamps/","page":"Timestamps","title":"Timestamps","text":"timestamp method(nd::NanoDate)\n2022-05-24T10:43:22.350_789 timestamp(floor(nd, Microsecond); sep=_)\n2022-05-24T10:43:22.350⬩789⬩123 timestamp(nd; sep=\"⬩\")","category":"page"},{"location":"use/timestamps/#timestamps-that-are-counts-offset-from-the-UNIX-Epoch-(1970-01-01-UTC)","page":"Timestamps","title":"timestamps that are counts offset from the UNIX Epoch (1970-01-01 UTC)","text":"","category":"section"},{"location":"use/timestamps/","page":"Timestamps","title":"Timestamps","text":"timestamp resolution method(nd::NanoDate)\n63789100018 second nanodate2unixseconds(nd)\n63789100018123 millisecond nanodate2unixmillis(nd)\n63789100018123456 microsecond nanodate2unixmicros(nd)","category":"page"},{"location":"use/timestamps/","page":"Timestamps","title":"Timestamps","text":"","category":"page"},{"location":"use/timestamps/#*to-request-another-timestamp-format,-please-raise-an-issue-[here](https://github.com/JeffreySarnoff/NanoDates.jl/issues)*","page":"Timestamps","title":"to request another timestamp format, please raise an issue here","text":"","category":"section"},{"location":"use/construction/#Constructing-NanoDates","page":"Construction","title":"Constructing NanoDates","text":"","category":"section"},{"location":"use/construction/","page":"Construction","title":"Construction","text":"All of the ways available to construct DateTimes work with NanoDates.  And there are a few additional constructors that make work microseconds and nanoseconds easier.  NanoDate constructors are best understood by example. We will set some variables for later clarity.","category":"page"},{"location":"use/construction/","page":"Construction","title":"Construction","text":"using Dates, NanoDates\n\n# lets establish the values for each period\n\nyears, months, days   = (2022,  6,  18)\nhours, mins, secs     = (12,   15,  30)\nmillis, micros, nanos = (123, 456, 789)\n\nadate = Date(years, months, days)\n# 2022-05-18\n\natime = Time(hours, mins, secs, millis, micros, nanos)\n# 12:15:30.123456789","category":"page"},{"location":"use/construction/","page":"Construction","title":"Construction","text":"Here are familiar constructor methods.","category":"page"},{"location":"use/construction/","page":"Construction","title":"Construction","text":"nd = NanoDate(adate)\n# 2022-05-18T00:00:00\n\nnd = NanoDate(adatetime)\n# 2022-05-18T12:15:20.123\n\nnd = NanoDate(adate, atime)\n# 2022-05-18T12:15:30.123456789","category":"page"},{"location":"use/construction/","page":"Construction","title":"Construction","text":"enhancement: date_time is safe from InexactErrors","category":"page"},{"location":"use/construction/","page":"Construction","title":"Construction","text":"daytime = date_time(adate, atime)\n# 2022-05-18T12:15:30.123","category":"page"},{"location":"use/intostring/#Converting-NanoDates-and-Strings","page":"Strings","title":"Converting NanoDates and Strings","text":"","category":"section"},{"location":"use/intostring/#To-obtain-your-NanoDate-as-a-String-is-to-use-string(nanodate).","page":"Strings","title":"To obtain your NanoDate as a String is to use string(nanodate).","text":"","category":"section"},{"location":"use/intostring/","page":"Strings","title":"Strings","text":"using Dates, NanoDates\n\nadatetime = DateTime(2022,06,18,12,15,30);\nsubsecond = Nanosecond(123_456_789);\n\nnd = NanoDate(adatetime, subsecond)\n# 2022-06-18T12:15:30.123456789\n\nstring(nd)  # \"2022-06-18T12:15:30.123456789\"","category":"page"},{"location":"use/intostring/#Use-timestamp-to-get-an-ISO8061-conoforming-string.","page":"Strings","title":"Use timestamp to get an ISO8061 conoforming string.","text":"","category":"section"},{"location":"use/intostring/","page":"Strings","title":"Strings","text":"timestamp(nd; utc=true)\n# \"2022-06-18T12:15:30.123456789Z\"\n\ntimestamp(nd; localtime=true)\n# \"2022-06-18T12:15:30.123456789-04:00\"","category":"page"},{"location":"use/intostring/#Accepting-ISO8061-conforming-strings-does-not-require-dateformat.","page":"Strings","title":"Accepting ISO8061 conforming strings does not require dateformat.","text":"","category":"section"},{"location":"use/intostring/","page":"Strings","title":"Strings","text":"NanoDate(\"2022-06-18T12:15:30.123456789Z\")\n# 2022-06-18T12:15:30.123456789\n\nNanoDate(\"2022-06-18T12:15:30.123456-04:00\")\n# 2022-05-18T12:15:30.123456","category":"page"},{"location":"use/intostring/#Accepting-strings-that-are-not-ISO8061-conforming-requires-a-dateformat.","page":"Strings","title":"Accepting strings that are not ISO8061 conforming requires a dateformat.","text":"","category":"section"},{"location":"use/intostring/","page":"Strings","title":"Strings","text":"NanoDate(\"-- 12345 2022-06-18 12:15:30\", \n         dateformat\"-- sssss yyyy-mm-dd HH:MM:SS\")\n# 2022-06-18T12:15:30.123450","category":"page"},{"location":"use/intostring/#More-easily-readable-is-string(nanodate;-sep'choose-a-Char'-).","page":"Strings","title":"More easily readable is string(nanodate; sep='<choose a Char>' ).","text":"","category":"section"},{"location":"use/intostring/","page":"Strings","title":"Strings","text":"string(nd; sep='_')\n# \"2022-06-18T12:15:30.123_456_789\"\n\nstring(nd; sep='◦')\n# \"2022-06-18T12:15:30.123◦456◦789\"","category":"page"},{"location":"appropriate/enhancements/#enhancements","page":"Enhancements","title":"enhancements","text":"","category":"section"},{"location":"appropriate/enhancements/#timestamps","page":"Enhancements","title":"timestamps","text":"","category":"section"},{"location":"appropriate/enhancements/#NanoDate-timestamp","page":"Enhancements","title":"NanoDate ⇌ timestamp","text":"","category":"section"},{"location":"appropriate/enhancements/","page":"Enhancements","title":"Enhancements","text":"roundtrip construction\nparsing with dateformat","category":"page"},{"location":"appropriate/enhancements/#ISO8061","page":"Enhancements","title":"ISO8061","text":"","category":"section"},{"location":"appropriate/enhancements/","page":"Enhancements","title":"Enhancements","text":"UTC times, end with 'Z'\ntimestamp(::NanoDate; utc=true)\nlocal times, end with offset from UTC (\"±hh:mm\")\ntimestamp(::NanoDate; localtime=true)","category":"page"},{"location":"appropriate/enhancements/#wallclock-time","page":"Enhancements","title":"wallclock time","text":"","category":"section"},{"location":"appropriate/enhancements/","page":"Enhancements","title":"Enhancements","text":"hours & minutes adjusted to localtime\ntimestamp(::NanoDate; localtime=true, postfix=false)","category":"page"},{"location":"appropriate/enhancements/#splicing-into-periods","page":"Enhancements","title":"splicing into periods","text":"","category":"section"},{"location":"appropriate/enhancements/","page":"Enhancements","title":"Enhancements","text":"replace Hour(nd) with Hour(5)\nNanoDate(nd, Hour(5))\nmove to Week(2) of Year(nd)\nNanoDate(nd, Week(2))","category":"page"},{"location":"appropriate/enhancements/#readability-options-(nd-timestamp-)","page":"Enhancements","title":"readability options (nd  ⇌ timestamp )","text":"","category":"section"},{"location":"appropriate/enhancements/","page":"Enhancements","title":"Enhancements","text":"subsecond separator\nNanoDate(\"2022-06-18T12:15:30.123_455_820\")\nsubstitute a space for 'T'\nNanoDate(\"2022-04-28 12:15:30\")","category":"page"},{"location":"use/accessors/#Getting-Parts-of-a-NanoDate","page":"Accessors","title":"Getting Parts of a NanoDate","text":"","category":"section"},{"location":"use/accessors/","page":"Accessors","title":"Accessors","text":"This works just the way it does with Date, Time, and DateTime.","category":"page"},{"location":"use/accessors/","page":"Accessors","title":"Accessors","text":"You can use year, month, day, .., nanosecond You can use Year, Month, Day, ... Nanosecond","category":"page"},{"location":"use/accessors/","page":"Accessors","title":"Accessors","text":"using Dates, NanoDates\n\nadate = Date(years, months, days)\n# 2022-06-18\n\natime = Time(hours, mins, secs, millis, micros, nanos)\n# 12:15:30.123456789\n\nnanodate = NanoDate(adate, atime)\n# 2022-06-18T12:15:30.123456789\n\nyear(nanodate) == 2022\nday(nanodate)  == 18\nhour(nanodate) == 12\nnanosecond(nanodate) == 789\n\nYear(nanodate) == Year(2022)\nDay(nanodate)  == Day(18)\nHour(nanodate) == Hour(12)\nNanosecond(nanodate) == Nanosecond(789)","category":"page"},{"location":"use/accessors/#Adding/Subtracting-Periods","page":"Accessors","title":"Adding/Subtracting Periods","text":"","category":"section"},{"location":"use/accessors/","page":"Accessors","title":"Accessors","text":"This works just the way it does with Date, Time, and DateTime.","category":"page"},{"location":"use/accessors/","page":"Accessors","title":"Accessors","text":"julia> nanodate\n2022-06-18T12:15:30.123456789\n\njulia> nanodate + Month(4)\n2022-10-28T14:32:10.123456789\n\njulia> nanodate + Month(7)\n2023-01-28T14:32:10.123456789\n\njulia> nanodate - Month(6) - Day(18)\n2021-11-30T12:15:30.123456789\n\njulia> nanodate - Microsecond(456)\n2021-12-28T14:32:10.123000789\n\njulia> nanodate - Nanosecond(456789)\n2021-12-28T00:32:10.123","category":"page"},{"location":"use/specify/#Construction-by-Specification","page":"Specification","title":"Construction by Specification","text":"","category":"section"},{"location":"use/specify/","page":"Specification","title":"Specification","text":"Here are some of the methods that take values","category":"page"},{"location":"use/specify/","page":"Specification","title":"Specification","text":"nd = NanoDate(years)\n# 2022-01-01T00:00:00\n\nnd = NanoDate(years, months)\n# 2022-06-01T00:00:00\n\nnd = NanoDate(years, months, days)\n# 2022-06-18T00:00:00\n\nnd = NanoDate(years, months, days, hours, mins)\n# 2022-06-18T12:15:00\n\nnd = NanoDate(years, months, days, hours, mins, secs)\n# 2022-06-18T12:15:30\n\nnd = NanoDate(years, months, days, \n              hours, mins, secs, millis, micros)\n# 2022-04-28T14:32:10.123456\n\nnd = NanoDate(years, months, days, \n              hours, mins, secs, millis, micros, nanos)\n# 2022-04-28T14:32:10.123456789","category":"page"},{"location":"use/specify/","page":"Specification","title":"Specification","text":"The same constructors work given Periods","category":"page"},{"location":"use/specify/","page":"Specification","title":"Specification","text":"nd = NanoDate(Year(years))\n# 2022-01-01T00:00:00\n\nnd = NanoDate(Year(years), Month(months))\n# 2022-06-01T00:00:00\n\nnd = NanoDate(\n    Year(years), Month(months), Day(days), \n    Hour(hours), Minute(mins), Second(secs))\n# 2022-06-18T12:15:30\n\nnd = NanoDate(\n    Year(years), Month(months), Day(days), \n    Hour(hours), Minute(mins), Second(secs),\n    Millisecond(millis), Microsecond(micros),\n    Nanosecond(nanos))\n# 2022-06-18T12:15:30.123456789","category":"page"},{"location":"use/convenient/#Convenient-Work-Alikes","page":"Conviences","title":"Convenient Work-Alikes","text":"","category":"section"},{"location":"use/convenient/","page":"Conviences","title":"Conviences","text":"Here are a few simple timesavers, DateTime work-alikes. ndnow(LOCAL), ndnow(UTC) are similar to now(), now(UTC), with support for microseconds and nanoseconds.","category":"page"},{"location":"use/convenient/","page":"Conviences","title":"Conviences","text":"# ndnow(LOCAL), ndnow(UTC) work like now(), now(UTC)\n\nnow(UTC)                     # 1 millisecond resolution\n# 2022-06-18T12:15:30.123\n\nndnow(LOCAL)                 # 100 nanosecond resolution (ymmv)\n# 2022-06-18T12:15:30.123456700\n\nndnow(UTC, Microsecond(321), Nanosecond(0))\n# 2022-06-18T12:15:30.123321\n\nndnow(LOCAL, Microsecond(321), Nanosecond(555))\n# 2022-06-18T12:15:30.12332555","category":"page"},{"location":"use/convenient/","page":"Conviences","title":"Conviences","text":"ndtoday(UTC) and ndtoday(LOCAL) are provided. They work like today(), adding UTC, LOCAL.","category":"page"},{"location":"use/convenient/","page":"Conviences","title":"Conviences","text":"ndtoday(UTC), ndtoday(LOCAL)\n# 2022-04-26, 2022-04-25","category":"page"},{"location":"#NanoDates.jl","page":"Home","title":"NanoDates.jl","text":"","category":"section"},{"location":"#a-date-and-time-type","page":"Home","title":"a date-and-time type","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Years, Months, Days\nHours, Minutes, Seconds\nMilliseconds, Microseconds, Nanoseconds","category":"page"},{"location":"#cooperates-with-Dates","page":"Home","title":"cooperates with Dates","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"NanoDate works like a more precise DateTime\nall Dates methods (afaik)\nconstruct from \nDateTime & Time, Date & Time\nDateTime & Microseconds [, Nanoseconds]\nDateTime, Date\ndeconstruct to\nDateTime, Date, Time\nuses DateFormat\none 's' for each subsecond digit\nformat(::NanoDate, ::DateFormat)","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"install with  using Pkg; Pkg.add(\"NanoDates\")\nask questions\non Discourse – add the tag time\non Zulip – using the stream dates-times-zones\nreport any issues here","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"appropriate/advantages/#Application","page":"Advantages","title":"Application","text":"","category":"section"},{"location":"appropriate/advantages/#NanoDates-put-Nanoseconds-into-timekeeping","page":"Advantages","title":"NanoDates put Nanoseconds into timekeeping","text":"","category":"section"},{"location":"appropriate/advantages/","page":"Advantages","title":"Advantages","text":"produce, consume, transmit microtimed occurances\ndesign using nanosecond resolved records\ncapable, conformant timestamping","category":"page"},{"location":"appropriate/advantages/","page":"Advantages","title":"Advantages","text":"","category":"page"},{"location":"appropriate/advantages/#Financial-Market-Operations","page":"Advantages","title":"Financial Market Operations","text":"","category":"section"},{"location":"appropriate/advantages/","page":"Advantages","title":"Advantages","text":"In 2018 finanical centers, through host countries, adopted regulations for participants in high frequency trading. Here are quotes from two regulators:","category":"page"},{"location":"appropriate/advantages/","page":"Advantages","title":"Advantages","text":"Market events and order transactions must be recorded and retraceable to UTC.","category":"page"},{"location":"appropriate/advantages/","page":"Advantages","title":"Advantages","text":"Systems that are syncronized to a [validated] clock, require timestamp availability at submillisecond resolutions. The shortest interval [required of] very high frequncy trading work as of 2022-Jun-01 is 25 ns. ","category":"page"},{"location":"appropriate/advantages/","page":"Advantages","title":"Advantages","text":"UTC is the timebase of record by international agreement and statutory law.","category":"page"},{"location":"appropriate/advantages/","page":"Advantages","title":"Advantages","text":"","category":"page"},{"location":"technical/DatesFunctions/#Getting-Integer-Valued-Information","page":"Internals","title":"Getting Integer Valued Information","text":"","category":"section"},{"location":"technical/DatesFunctions/","page":"Internals","title":"Internals","text":"","category":"page"},{"location":"technical/DatesFunctions/#low-level-internals-from-Dates","page":"Internals","title":"low level internals from Dates","text":"","category":"section"},{"location":"technical/DatesFunctions/","page":"Internals","title":"Internals","text":"function mapping\nvalue(x::T): x –> value stored in x::T\ntoms(x::Period): x –> milliseconds\ntons(x::Period): x –> nanoseconds\n \ndays(x::Date) x –> daycount (RataDie)\ndays(x::DateTime) x –> daycount (RataDie)","category":"page"},{"location":"technical/DatesFunctions/","page":"Internals","title":"Internals","text":"","category":"page"}]
}
