Base.isequal(x::NanoDate, y::NanoDate) =
    isequal(x.datetime, y.datetime) && isequal(x.nanosecs, y.nanosecs)

Base.isequal(x::NanoDate, y::Date) =
    isequal(x.datetime, y) && iszero(x.nanosecs)
Base.isequal(x::Date, y::NanoDate) =
    isequal(x, y.datetime) && iszero(y.nanosecs)

Base.isequal(x::NanoDate, y::DateTime) =
    isequal(x.datetime, y) && iszero(x.nanosecs)
Base.isequal(x::DateTime, y::NanoDate) =
    isequal(x, y.datetime) && iszero(y.nanosecs)

Base.isless(x::NanoDate, y::NanoDate) =
    isless(x.datetime, y.datetime) ||
    (isequal(x.datetime, y.datetime) && isless(x.nanosecs, y.nanosecs))

Base.isless(x::NanoDate, y::Date) = isless(x.datetime, y)
Base.isless(x::Date, y::NanoDate) = 
    isless(x, y.datetime) ||
    (isequal(x, y.datetime) && !iszero(y.nanosecs))

Base.isless(x::NanoDate, y::DateTime) = isless(x.datetime, y)
Base.isless(x::DateTime, y::NanoDate) = 
    isless(x, y.datetime) ||
    (isequal(x, y.datetime) && !iszero(y.nanosecs))

Base.:(==)(x::NanoDate, y::NanoDate) =
    (x.datetime == y.datetime) && (x.nanosecs == y.nanosecs)
Base.:(<)(x::NanoDate, y::NanoDate) =
    (x.datetime < y.datetime) || (x.datetime == y.datetime && x.nanosecs < y.nanosecs)
Base.:(<=)(x::NanoDate, y::NanoDate) =
    (x.datetime < y.datetime) || (x.datetime == y.datetime && x.nanosecs <= y.nanosecs)
Base.:(>)(x::NanoDate, y::NanoDate) =
    (x.datetime > y.datetime) || (x.datetime == y.datetime && x.nanosecs > y.nanosecs)
Base.:(>=)(x::NanoDate, y::NanoDate) =
    (x.datetime > y.datetime) || (x.datetime == y.datetime && x.nanosecs >= y.nanosecs)

for (T) in (:DateTime, :Date)
  @eval begin
    Base.:(==)(x::NanoDate, y::$T) = (x.datetime == y) && iszero(x.nanosecs)
    Base.:(==)(x::$T, y::NanoDate) = (x == y.datetime) && iszero(y.nanosecs)

    Base.:(<)(x::NanoDate, y::$T) = (x.datetime < y)
    Base.:(<)(x::$T, y::NanoDate) = (x < y.datetime)
    Base.:(>)(x::NanoDate, y::$T) = (x.datetime > y) || (x.datetime == y && !iszero(x.nanosecs))
    Base.:(>)(x::$T, y::NanoDate) = (x > y.datetime) 

    Base.:(<=)(x::NanoDate, y::$T) = (x < y) || (x == y)
    Base.:(<=)(x::$T, y::NanoDate) = (x < y) || (x == y)
    Base.:(>=)(x::NanoDate, y::$T) = (x > y) || (x == y)
    Base.:(>=)(x::$T, y::NanoDate) = (x > y) || (x == y)
  end
end

for i in 1:Nperiods
  Base.isequal(::Type{AllPeriodsDecreasing[i]}, ::Type{AllPeriodsDecreasing[i]}) = true
  Base.isless(::Type{AllPeriodsDecreasing[i]}, ::Type{AllPeriodsDecreasing[i]}) = false
  for k in i+1:Nperiods
    Base.isequal(::Type{AllPeriodsDecreasing[i]}, ::Type{AllPeriodsDecreasing[k]}) = false
    Base.isequal(::Type{AllPeriodsDecreasing[k]}, ::Type{AllPeriodsDecreasing[i]}) = false
    Base.isless(::Type{AllPeriodsDecreasing[i]}, ::Type{AllPeriodsDecreasing[k]}) = false
    Base.isless(::Type{AllPeriodsDecreasing[k]}, ::Type{AllPeriodsDecreasing[i]}) = true
  end
end

