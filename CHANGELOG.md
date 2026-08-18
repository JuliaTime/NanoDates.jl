# Changelog

## 2.0.0

### Breaking

- A `CompoundPeriod` applies its coarser periods before its finer ones, the order
  [Dates documents](https://docs.julialang.org/en/v1/stdlib/Dates/#TimeType-Period-Arithmetic).
  `NanoDate(2014, 1, 29) + (Day(1) + Month(1))` gives `2014-03-01` rather than `2014-02-28`.
- `canonical` returns a `CompoundPeriod` for every argument. It used to return a bare
  `Period` when the result held a single component.
- `canonical` of a zero period returns an empty `CompoundPeriod` rather than that zero
  period.
- `Dates.value(::CompoundPeriod)` counts nanoseconds exactly as an `Int128`. It used to
  go through `Float64` and drop digits, so `value(Year(100) + Nanosecond(1))` gives
  `3155695200000000001` rather than `3.1556952e18`.
- The `julia` compat bound is 1.8. The declared bound was 1.7, where the package could
  never load, because its typed global declarations are a syntax error before 1.8.

### Fixed

- `canonical(::Millisecond, ::Microsecond)` threw an `UndefVarError` for every argument.
- `ndnow_strict` threw an `UndefVarError` whenever the monotonic clock reported a
  smaller reading than on the previous call.
- Subtracting an empty `CompoundPeriod` threw a `MethodError`, whether the minuend was
  a `CompoundPeriod` or a `Period`.

### Changed

- Subtracting a `CompoundPeriod` from a `CompoundPeriod` or from a `Period` infers
  `CompoundPeriod` as its return type rather than `Any`.
- `canonical` infers `CompoundPeriod` as its return type rather than `Any`.
- Adding a `CompoundPeriod` to a `NanoDate`, a `Time` or a `DateTime` infers the type
  of the first argument rather than `Any`.
- `format(::NanoDate, ::DateFormat)` infers `String` rather than
  `Union{String, SubString{String}}`.
