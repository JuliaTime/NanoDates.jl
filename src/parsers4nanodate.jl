# We cannot add an entry for `NanoDate` into `Dates.CONVERSION_TRANSLATORS`,
# so the entire JuliaData/Parsers.jl/src/dates.jl is duplicated then modified.
# This specializes  JuliaData/Parsers.jl/src/dates.jl to work with NanoDates.

# user level exports 
export ISONanoDateFormat

# importing what is not exported from Dates
#   that is used in this source file
import Dates: DatePart, Delim, validargs, argerror

import Parsers: tryparse, tryparsenext, tryparsenext_base10,
    Format, default_format, charactercode,
    Options, Result

const ISONanoDateFormat = Format("yyyy-mm-dd\\THH:MM:SS.sss")
Dates.default_format(::Type{NanoDate}) = ISONanoDateFormat


function Dates.validargs(::Type{NanoDate}, 
           y::Year, m::Month, d::Day, 
           h::Hour, mi::Minute, s::Second,
           ms::Millisecond, us::Microsecond, ns::Nanosecond, 
           ampm::Dates.AMPM)
    extents = map(value, (y,m,d,h,mi,s,ms,us,ns))
    validargs(NanoDate, extents..., ampm)
end

function Dates.validargs(::Type{NanoDate}, y::T, m::T, d::T, 
    h::T, mi::T, s::T, ms::T, us::T, ns::T, 
    ampm::Dates.AMPM=Dates.TWENTYFOURHOUR) where {T<:Union{Int64, Int128}}
    0 < m < 13 || return Dates.argerror("Month: $m out of range (1:12)")
    0 < d < daysinmonth(y, m) + 1 || return Dates.argerror("Day: $d out of range (1:$(daysinmonth(y, m)))")
    if ampm == Dates.TWENTYFOURHOUR # 24-hour clock
        -1 < h < 24 || return Dates.argerror("Hour: $h out of range (0:23)")
    else
        0 < h < 13 || return Dates.argerror("Hour: $h out of range (1:12)")
    end
    -1 < mi < 60 || return Dates.argerror("Minute: $mi out of range (0:59)")
    -1 < s < 60 || return Dates.argerror("Second: $s out of range (0:59)")
    -1 < ms < 1000 || return Dates.argerror("Millisecond: $ms out of range (0:999)")
    -1 < us < 1000 || return Dates.argerror("Microsecond: $us out of range (0:999)")
    -1 < ns < 1000 || return Dates.argerror("Nanosecond: $ns out of range (0:999)")
    return Dates.argerror()
end


Base.getindex(collection::IdDict{Type,Any}, ::Type{NanoDate}) =
    (Year, Month, Day, Hour, Minute, Second, Millisecond, Microsecond, Nanosecond)

    
@inline  function typeparser(::Type{NanoDate}, source, pos, len, b, code, options)
    fmt = options.dateformat
    df = fmt === nothing ? default_format(T) : fmt
    tokens = df.tokens
    locale::Dates.DateLocale = df.locale
    year = month = day = Int64(1)
    hour = minute = second = millisecond = microsecond = nanosecond = Int64(0)
    tz = ""
    ampm = Dates.TWENTYFOURHOUR
    extras = nothing

    pos, len, b, code = tryparsetokens(tokens, pos, len, b, code, locale, extras)
    pos, len, b, code
end

function tryparsetokens(tokens, pos, len, b, code, locale)
    for tok in tokens
        # @show pos, Char(b), code, typeof(tok)
        eof(code) && break
        if tok isa Delim{Char}
            pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif tok isa Delim{String}
            pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif tok isa Dates.DatePart{'y'}
            year, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif tok isa Dates.DatePart{'Y'}
            year, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif tok isa Dates.DatePart{'m'}
            month, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif tok isa Dates.DatePart{'u'}
            month, pos, b, code = tryparsenext(tok, source, pos, len, b, code, locale)
        elseif tok isa Dates.DatePart{'U'}
            month, pos, b, code = tryparsenext(tok, source, pos, len, b, code, locale)
        elseif tok isa Dates.DatePart{'d'}
            day, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif tok isa Dates.DatePart{'e'}
            _, pos, b, code = tryparsenext(tok, source, pos, len, b, code, locale)
        elseif tok isa Dates.DatePart{'E'}
            _, pos, b, code = tryparsenext(tok, source, pos, len, b, code, locale)
        elseif tok isa Dates.DatePart{'H'}
            hour, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif tok isa Dates.DatePart{'I'}
            hour, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif tok isa Dates.DatePart{'M'}
            minute, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif tok isa Dates.DatePart{'S'}
            second, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif tok isa Dates.DatePart{'p'}
            ampm, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif tok isa Dates.DatePart{'s'}
            if tok.width >= 1
                millisecond, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
            end
            if tok.width >= 2
                microsecond, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
            end
            if tok.width >= 3
                nanosecond, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
            end
        elseif tok isa Dates.DatePart{'z'}
            tz, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif tok isa Dates.DatePart{'Z'}
            tz, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        else
            # non-Dates defined character code
            # allocate extras if not already and parse
            if extras === nothing
                extras = Dict{Type,Any}()
            end
            extraval, pos, b, code = tryparsenext(tok, source, pos, len, b, code)::Tuple{Any,Int,UInt8,ReturnCode}
            extras[Dates.CONVERSION_SPECIFIERS[charactercode(tok)]] = extraval
        end
    
        if invalid(code)
            if invalidtoken(code)
                code &= ~INVALID_TOKEN
            end
            break
        end
        # @show pos, Char(b), code
    end
    pos, len, b, code
end


    valid = Dates.validargs(NanoDate, year, month, day, hour, minute, second, millisecond, microsecond, nanosecond, Dates.TWENTYFOURHOUR)

#=    
    elseif T.name.name === :ZonedDateTime
        valid = Dates.validargs(T, year, month, day, hour, minute, second, millisecond, tz)
    else
        # custom TimeType
        if extras === nothing
            extras = Dict{Type,Any}()
        end
        extras[Year] = year
        extras[Month] = month
        extras[Day] = day
        extras[Hour] = hour
        extras[Minute] = minute
        extras[Second] = second
        extras[Millisecond] = millisecond
        extras[Microsecond] = microsecond
        extras[Nanosecond]  = nanosecond
        types = Dates.CONVERSION_TRANSLATIONS[T]
        vals = Vector{Any}(undef, length(types))
        for (i, type) in enumerate(types)
            vals[i] = get(extras, type) do
                Dates.CONVERSION_DEFAULTS[type]
            end
        end
        valid = Dates.validargs(T, vals...)
    end
    if invalid(code) || valid !== nothing
        if T.name.name === :ZonedDateTime
            x = T(0, TimeZone("UTC"))
        else
            x = T(0)
        end
        code |= INVALID
    else
        # xdate = Date(Dates.UTD(Dates.totaldays(year, month, day)))
        # xtime = Time(Nanosecond(1000000 * millisecond + 1000000000 * second + 60000000000 * minute + 3600000000000 * (Dates.adjusthour(hour, ampm))))
        # x = NanoDate(xdate, xtime)
        xnanosecs = Nanosecond(microsecond * 1000 + nanosecond)
        xdatetime = DateTime(Dates.UTM(millisecond + 1000 * (second + 60 * minute + 3600 * (Dates.adjusthour(hour, ampm)) + 86400 * Dates.totaldays(year, month, day))))
        x = NanoDate(xdatetime, xnanosecs)
        code |= OK
    end
    if eof(source, pos, len)
        code |= EOF
    end
    return x, code, pos
end
=#

#=
Parsers.xparse(::Type{NanoDate}, source::Union{AbstractVector{UInt8},IO}, pos, len, options::Parsers.Options=Parsers.XOPTIONS, ::Type{S}=NanoDate) where {S} = true


const DatePeriods = (Year, Month, Day)
const TimePeriods = (Hour, Minute, Second, Millisecond, Microsecond, Nanosecond)
const DateTimePeriods = (DatePeriods..., TimePeriods[1:end-2]...)
const NanoDatePeriods = (DatePeriods..., TimePeriods...)

const CONVERSION_WITH_TRANSLATIONS =
    IdDict(NanoDate => NanoDatePeriods,
        DateTime => DateTimePeriods,
        Time => TimePeriods,
        Date => DatePeriods)
=#
#=
@inline function tryparsenext(d::Dates.DatePart{'s'}, source, pos, len, b, code)
    ms0, newpos, b, code = tryparsenext_base10(source, pos, len, b, code, maxdigits(d))
    invalid(code) && return ms0, newpos, b, code
    len = newpos - pos
    if len > 3
        ms, r = divrem(ms0, Int64(10) ^ (len - 3))
        if r != 0
            code |= INVALID
        end
    else
        ms = ms0 * Int64(10) ^ (3 - len)
    end
    return ms, newpos, b, code
end
=#
#=
# fallback that would call custom DatePart overloads that are expecting a string
function tryparsenext(tok, source, pos, len, b, code)::Tuple{Any, Int, UInt8, ReturnCode}
    strlen = min(len - pos + 1, 64)
    str = getstring(source, PosLen(pos, strlen), 0x00)
    res = Dates.tryparsenext(tok, str, 1, strlen)
    if res === nothing
        val = nothing
        code |= INVALID_TOKEN
    else
        val, i = res
        pos += i - 1
        if eof(source, pos, len)
            code |= EOF
        else
            b = peekbyte(source, pos)
        end
    end
    return val, pos, b, code
end
=#
#=
@inline function typeparser(::Type{T}, source, pos, len, b, code, options) where {T <: Dates.TimeType}
    fmt = options.dateformat
    df = fmt === nothing ? default_format(T) : fmt
    tokens = df.tokens
    locale::Dates.DateLocale = df.locale
    year = month = day = Int64(1)
    hour = minute = second = millisecond = Int64(0)
    tz = ""
    ampm = Dates.TWENTYFOURHOUR
    extras = nothing
    for tok in tokens
        # @show pos, Char(b), code, typeof(tok)
        eof(code) && break
        if tok isa Delim{Char}
            pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif tok isa Delim{String}
            pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif T !== Time && tok isa Dates.DatePart{'y'}
            year, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif T !== Time && tok isa Dates.DatePart{'Y'}
            year, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif T !== Time && tok isa Dates.DatePart{'m'}
            month, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif T !== Time && tok isa Dates.DatePart{'u'}
            month, pos, b, code = tryparsenext(tok, source, pos, len, b, code, locale)
        elseif T !== Time && tok isa Dates.DatePart{'U'}
            month, pos, b, code = tryparsenext(tok, source, pos, len, b, code, locale)
        elseif T !== Time && tok isa Dates.DatePart{'d'}
            day, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif T !== Time && tok isa Dates.DatePart{'e'}
            _, pos, b, code = tryparsenext(tok, source, pos, len, b, code, locale)
        elseif T !== Time && tok isa Dates.DatePart{'E'}
            _, pos, b, code = tryparsenext(tok, source, pos, len, b, code, locale)
        elseif T !== Date && tok isa Dates.DatePart{'H'}
            hour, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif T !== Date && tok isa Dates.DatePart{'I'}
            hour, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif T !== Date && tok isa Dates.DatePart{'M'}
            minute, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif T !== Date && tok isa Dates.DatePart{'S'}
            second, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif T !== Date && tok isa Dates.DatePart{'p'}
            ampm, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif T !== Date && tok isa Dates.DatePart{'s'}
            millisecond, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif tok isa Dates.DatePart{'z'}
            tz, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        elseif tok isa Dates.DatePart{'Z'}
            tz, pos, b, code = tryparsenext(tok, source, pos, len, b, code)
        else
            # non-Dates defined character code
            # allocate extras if not already and parse
            if extras === nothing
                extras = Dict{Type, Any}()
            end
            extraval, pos, b, code = tryparsenext(tok, source, pos, len, b, code)::Tuple{Any, Int, UInt8, ReturnCode}
            extras[Dates.CONVERSION_SPECIFIERS[charactercode(tok)]] = extraval
        end
        if invalid(code)
            if invalidtoken(code)
                code &= ~INVALID_TOKEN
            end
            break
        end
        # @show pos, Char(b), code
    end

    if T === Time
        @static if VERSION >= v"1.3-DEV"
            valid = Dates.validargs(T, hour, minute, second, millisecond, Int64(0), Int64(0), ampm)
        else
            valid = Dates.validargs(T, hour, minute, second, millisecond, Int64(0), Int64(0))
        end
    elseif T === Date
        valid = Dates.validargs(T, year, month, day)
    elseif T === DateTime
        @static if VERSION >= v"1.3-DEV"
            valid = Dates.validargs(T, year, month, day, hour, minute, second, millisecond, ampm)
        else
            valid = Dates.validargs(T, year, month, day, hour, minute, second, millisecond)
        end
    elseif T.name.name === :ZonedDateTime
        valid = Dates.validargs(T, year, month, day, hour, minute, second, millisecond, tz)
    else
        # custom TimeType
        if extras === nothing
            extras = Dict{Type, Any}()
        end
        extras[Year] = year; extras[Month] = month; extras[Day] = day;
        extras[Hour] = hour; extras[Minute] = minute; extras[Second] = second; extras[Millisecond] = millisecond;
        types = Dates.CONVERSION_WITH_TRANSLATIONS[T]
        vals = Vector{Any}(undef, length(types))
        for (i, type) in enumerate(types)
            vals[i] = get(extras, type) do
                Dates.CONVERSION_DEFAULTS[type]
            end
        end
        valid = Dates.validargs(T, vals...)
    end
    if invalid(code) || valid !== nothing
        if T.name.name === :ZonedDateTime
            x = T(0, TimeZone("UTC"))
        else
            x = T(0)
        end
        code |= INVALID
    else
        if T === Time
            @static if VERSION >= v"1.3-DEV"
                x = Time(Nanosecond(1000000 * millisecond + 1000000000 * second + 60000000000 * minute + 3600000000000 * (Dates.adjusthour(hour, ampm))))
            else
                x = Time(Nanosecond(1000000 * millisecond + 1000000000 * second + 60000000000 * minute + 3600000000000 * hour))
            end
        elseif T === Date
            x = Date(Dates.UTD(Dates.totaldays(year, month, day)))
        elseif T === DateTime
            @static if VERSION >= v"1.3-DEV"
                x = DateTime(Dates.UTM(millisecond + 1000 * (second + 60 * minute + 3600 * (Dates.adjusthour(hour, ampm)) + 86400 * Dates.totaldays(year, month, day))))
            else
                x = DateTime(Dates.UTM(millisecond + 1000 * (second + 60 * minute + 3600 * hour + 86400 * Dates.totaldays(year, month, day))))
            end
        elseif T.name.name === :ZonedDateTime
            x = T(year, month, day, hour, minute, second, millisecond, tz)
        else
            # custom TimeType
            x = T(vals...)
        end
        code |= OK
    end
    if eof(source, pos, len)
        code |= EOF
    end
    return x, code, pos
end
=#

# THAT Would Be Awesome