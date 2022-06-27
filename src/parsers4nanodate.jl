# We cannot add an entry for `NanoDate` into `Dates.CONVERSION_TRANSLATORS`,
# so the entire JuliaData/Parsers.jl/src/dates.jl is duplicated then modified.
# This specializes  JuliaData/Parsers.jl/src/dates.jl to work with NanoDates.


const ISONanoDateFormat = dateformat"yyyy-mm-ddTHH:MM:SS.sss"

Dates.default_format(::Type{NanoDate}) = ISONanoDateFormat

function Dates.validargs(::Type{NanoDate}, y::T, m::T, d::T,
    h::T, mi::T, s::T, ms::T, us::T, ns::T,
    ampm::Dates.AMPM=Dates.TWENTYFOURHOUR) where {T<:Union{Int64,Int128}}
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

