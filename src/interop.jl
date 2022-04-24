"""
    nanonow() -> NanoDate

The user's time in the system timezone locale

    nanonow(::Type{UTC}) -> NanoDate

The user's time as UTC/GMT
""" nanonow

@inline function nanonow()
    NanoDate(now())
end

@inline function nanonow(::Type{UTC})
    NanoDate(now(UTC))
end