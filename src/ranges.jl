Base.:(:)(a::T, b::T) where {T<:NanoDate} = (:)(a, Day(1), b)

guess(a::NanoDate, b::NanoDate, c) = floor(Int64, (Int128(value(b)) - Int128(value(a))) / toms(c))
len(a::NanoDate, b::NanoDate, c) = Int64(div(value(b - a), tons(c)))
