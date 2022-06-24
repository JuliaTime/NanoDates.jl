
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

