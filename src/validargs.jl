# We cannot add an entry for `NanoDate` into `Dates.CONVERSION_TRANSLATORS`,
# so the entire JuliaData/Parsers.jl/src/dates.jl is duplicated then modified.
# This specializes  JuliaData/Parsers.jl/src/dates.jl to work with NanoDates.


const ISONanoDateFormat = dateformat"yyyy-mm-ddTHH:MM:SS.sss"

Dates.default_format(::Type{NanoDate}) = ISONanoDateFormat

function Dates.validargs(::Type{NanoDate};
    year::T=year(today(UTC)), month::T=1, day::T=1,
    hour::T=0, minute::T=0, second::T=0,
    millisecond::T=0, microsecond::T=0, nanosecond::T=0,
    ampm::Dates.AMPM=Dates.TWENTYFOURHOUR) where {T<:Union{Int64,Int128}}

    validornot(0, month, 13, Month)
    validornot(0, day, 1 + daysinmonth(year, month), Day)
    ampm === Dates.TWENTYFOURHOUR ? validornot(-1, hour, 24, Hour) : validornot(0, hour, 13, Hour)
    validornot(-1, minute, 60, Minute)
    validornot(-1, second, 60, Second)
    validornot(-1, millisecond, 1000, Millisecond)
    validornot(-1, microsecond, 1000, Microsecond)
    validornot(-1, nanosecond, 1000, Nanosecond)
    return Dates.argerror()
end

@inline validornot(below, value, above, period::Type{P}) where {P<:Period} =
    (below < value < above) ||
    throw(Dates.argerror("$(period): $value is outside of ($(below+1):$(above-1))"))
