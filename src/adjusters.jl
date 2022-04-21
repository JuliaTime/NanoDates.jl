### trunction

Base.trunc(dt::NanoDate, p::Type{Year}) = NanoDate(trunc(Date(dt), Year))
Base.trunc(dt::NanoDate, p::Type{Quarter}) = NanoDate(trunc(Date(dt), Quarter))
Base.trunc(dt::NanoDate, p::Type{Month}) = NanoDate(trunc(Date(dt), Month))
Base.trunc(dt::NanoDate, p::Type{Day}) = NanoDate(Date(dt))
Base.trunc(dt::NanoDate, p::Type{Hour}) = dt - Minute(dt) - Second(dt) - Millisecond(dt)
Base.trunc(dt::NanoDate, p::Type{Minute}) = dt - Second(dt) - Millisecond(dt)
Base.trunc(dt::NanoDate, p::Type{Second}) = dt - Millisecond(dt)
Base.trunc(dt::NanoDate, p::Type{Millisecond}) = dt
Base.trunc(dt::NanoDate, p::Type{Microecond}) = dt - Millisecond(dt)
Base.trunc(dt::NanoDate, p::Type{Nanosecond}) = dt - Millisecond(dt)
