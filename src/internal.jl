
using Dates, NanoDates, Parsers;


translation_keys = collect(keys(Dates.CONVERSION_TRANSLATIONS));
push!(translation_keys, NanoDates.NanoDate);

translation_values = collect(values(Dates.CONVERSION_TRANSLATIONS));
push!(translation_values, (Year, Month, Day, Hour, Minute, Second, Millisecond, Microsecond, Nanosecond, Dates.AMPM));

const CONVERSIONTRANSLATIONS = IdDict(zip(translation_keys, translation_values));


function Dates.validargs(::Type{NanoDate}, year::Int64=year(today()), 
                                           month::Int64=one(Int64), day::Int64=one(Int64),
                                           hour::Int64=0, minute::Int64=0, second::Int64=0,
                                           millisecond::Int64=0, microsecond::Int64=0,
                                           nanosecond::Int64=0)

    Dates.validargs(Dates.Date, year, month, day)
    Dates.validargs(Dates.Time, hour, minute, second, 
                                millisecond, microsecond, nanosecond)
end


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

@inline function typeparser(::Type{T}, source, pos, len, b, code, options) where {T<:NanoDate}
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

    valid = Dates.validargs(T, year, month, day, hour, minute, second, millisecond, microsecond, nanosecond)
    if eof(source, pos, len)
        code |= EOF
    end
    return x, code, pos
end


nd = NanoDate(2022, 4, 27,  12, 21, 0,  123, 456, 789); ndstr=string(nd);



@inline function typeparser(::Type{NanoDate}, source, pos, len, b, code, options)
    T = NanoDate
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

    valid = Dates.validargs(T, year, month, day, hour, minute, second, millisecond, microsecond, nanosecond)
    if eof(source, pos, len)
        code |= EOF
    end
    return x, code, pos
end


nd = NanoDate(2022, 4, 27,  12, 21, 0,  123, 456, 789); ndstr=string(nd);
