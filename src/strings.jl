function Base.string(nd::NanoDate)
    str = string(nd.datetime)
    nanos = value(nd.nanosecs)
    nanos === 0 && return str
    padded = lpad(nanos, (nanos % 1_000) === 0 ? 3 : 6)
    str * padded
end
