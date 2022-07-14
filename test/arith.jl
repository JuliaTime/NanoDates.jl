@testset "add periods" begin
    @test nd + Year(1) == NanoDate(yr + 1, mn, dy, hr, mi, sc, ms, μs, ns)
    @test nd + Month(1) == NanoDate(yr, mn + 1, dy, hr, mi, sc, ms, μs, ns)
    @test nd + Day(1) == NanoDate(yr, mn, dy + 1, hr, mi, sc, ms, μs, ns)
    @test nd + Hour(1) == NanoDate(yr, mn, dy, hr + 1, mi, sc, ms, μs, ns)
    @test nd + Minute(1) == NanoDate(yr, mn, dy, hr, mi + 1, sc, ms, μs, ns)
    @test nd + Second(1) == NanoDate(yr, mn, dy, hr, mi, sc + 1, ms, μs, ns)
    @test nd + Millisecond(1) == NanoDate(yr, mn, dy, hr, mi, sc, ms + 1, μs, ns)
    @test nd + Microsecond(1) == NanoDate(yr, mn, dy, hr, mi, sc, ms, cs + 1, ns)
    @test nd + Nanosecond(1) == NanoDate(yr, mn, dy, hr, mi, sc, ms, μs, ns + 1)
end

@testset "subtract periods" begin

    @test nd - Year(1) == NanoDate(yr - 1, mn, dy, hr, mi, sc, ms, μs, ns)
    @test nd - Month(1) == NanoDate(yr, mn - 1, dy, hr, mi, sc, ms, μs, ns)
    @test nd - Day(1) == NanoDate(yr, mn, dy - 1, hr, mi, sc, ms, μs, ns)
    @test nd - Hour(1) == NanoDate(yr, mn, dy, hr - 1, mi, sc, ms, μs, ns)
    @test nd - Minute(1) == NanoDate(yr, mn, dy, hr, mi - 1, sc, ms, μs, ns)
    @test nd - Second(1) == NanoDate(yr, mn, dy, hr, mi, sc - 1, ms, μs, ns)
    @test nd - Millisecond(1) == NanoDate(yr, mn, dy, hr, mi, sc, ms - 1, μs, ns)
    @test nd - Microsecond(1) == NanoDate(yr, mn, dy, hr, mi, sc, ms, cs - 1, ns)
    @test nd - Nanosecond(1) == NanoDate(yr, mn, dy, hr, mi, sc, ms, μs, ns - 1)

end

@testset "trunc to period" begin

    @test trunc(nd, Year) == NanoDate(yr)
    @test trunc(nd, Month) == NanoDate(yr, mn)
    @test trunc(Date(nd), Week) == trunc(firstdayofweek(Date(nd), Day))
    @test trunc(nd, Day) == NanoDate(yr, mn, dy)
    @test trunc(nd, Hour) == NanoDate(yr, mn, dy, hr)
    @test trunc(nd, Minute) == NanoDate(yr, mn, dy, hr, mi)
    @test trunc(nd, Second) == NanoDate(yr, mn, dy, hr, mi, sc)
    @test trunc(nd, Millisecond) == NanoDate(yr, mn, dy, hr, mi, sc, ms)
    @test trunc(nd, Microsecond) == NanoDate(yr, mn, dy, hr, mi, sc, ms, cs)
    @test trunc(nd, Nanosecond) == NanoDate(yr, mn, dy, hr, mi, sc, ms, μs, ns)

end

@testset "floor to period" begin

    @test floor(nd, Year) == NanoDate(yr)
    @test floor(nd, Month) == NanoDate(yr, mn)
    @test floor(nd, Day) == NanoDate(yr, mn, dy)
    @test floor(nd, Hour) == NanoDate(yr, mn, dy, hr)
    @test floor(nd, Minute) == NanoDate(yr, mn, dy, hr, mi)
    @test floor(nd, Second) == NanoDate(yr, mn, dy, hr, mi, sc)
    @test floor(nd, Millisecond) == NanoDate(yr, mn, dy, hr, mi, sc, ms)
    @test floor(nd, Microsecond) == NanoDate(yr, mn, dy, hr, mi, sc, ms, cs)
    @test floor(nd, Nanosecond) == NanoDate(yr, mn, dy, hr, mi, sc, ms, μs, ns)

end

@testset "ceil to period" begin

    @test ceil(nd, Year) == NanoDate(yr + !isone(mn))
    @test ceil(nd, Month) == NanoDate(yr, mn + !isone(dy))
    @test ceil(nd, Day) == NanoDate(yr, mn, dy + !iszero(hr))
    @test ceil(nd, Hour) == NanoDate(yr, mn, dy, hr + !iszero(mi))
    @test ceil(nd, Minute) == NanoDate(yr, mn, dy, hr, mi + !iszero(sc))
    @test ceil(nd, Second) == NanoDate(yr, mn, dy, hr, mi, sc + !iszero(ms))
    @test ceil(nd, Millisecond) == NanoDate(yr, mn, dy, hr, mi, sc, ms + !iszero(cs))
    @test ceil(nd, Microsecond) == NanoDate(yr, mn, dy, hr, mi, sc, ms, cs + !iszero(ns))
    @test ceil(nd, Nanosecond) == NanoDate(yr, mn, dy, hr, mi, sc, ms, μs, ns)

end

@testset "round down to period" begin

    @test round(nd, Year, RoundDown) == NanoDate(yr)
    @test round(nd, Month, RoundDown) == NanoDate(yr, mn)
    @test round(nd, Day, RoundDown) == NanoDate(yr, mn, dy)
    @test round(nd, Hour, RoundDown) == NanoDate(yr, mn, dy, hr)
    @test round(nd, Minute, RoundDown) == NanoDate(yr, mn, dy, hr, mi)
    @test round(nd, Second, RoundDown) == NanoDate(yr, mn, dy, hr, mi, sc)
    @test round(nd, Millisecond, RoundDown) == NanoDate(yr, mn, dy, hr, mi, sc, ms)
    @test round(nd, Microsecond, RoundDown) == NanoDate(yr, mn, dy, hr, mi, sc, ms, cs)
    @test round(nd, Nanosecond, RoundDown) == NanoDate(yr, mn, dy, hr, mi, sc, ms, μs, ns)

end

@testset "round up to period" begin

    @test round(nd, Year, RoundUp) == NanoDate(yr + !isone(mn))
    @test round(nd, Month, RoundUp) == NanoDate(yr, mn + !isone(dy))
    @test round(nd, Day, RoundUp) == NanoDate(yr, mn, dy + !iszero(hr))
    @test round(nd, Hour, RoundUp) == NanoDate(yr, mn, dy, hr + !iszero(mi))
    @test round(nd, Minute, RoundUp) == NanoDate(yr, mn, dy, hr, mi + !iszero(sc))
    @test round(nd, Second, RoundUp) == NanoDate(yr, mn, dy, hr, mi, sc + !iszero(ms))
    @test round(nd, Millisecond, RoundUp) == NanoDate(yr, mn, dy, hr, mi, sc, ms + !iszero(cs))
    @test round(nd, Microsecond, RoundUp) == NanoDate(yr, mn, dy, hr, mi, sc, ms, cs + !iszero(ns))
    @test round(nd, Nanosecond, RoundUp) == NanoDate(yr, mn, dy, hr, mi, sc, ms, μs, ns)

end

@testset "round nearest (ties up) to period" begin

    @test round(nd, Year, RoundNearestTiesUp) == NanoDate(yr + (mn >= 6))
    @test round(nd, Month, RoundNearestTiesUp) == NanoDate(yr, mn + (dy >= daysinmonth(yr, mn)/2))
    @test round(nd, Day, RoundNearestTiesUp) == NanoDate(yr, mn, dy + (hr >= 12))
    @test round(nd, Hour, RoundNearestTiesUp) == NanoDate(yr, mn, dy, hr + (mn >= 30))
    @test round(nd, Minute, RoundNearestTiesUp) == NanoDate(yr, mn, dy, hr, mi + (sc >= 30))
    @test round(nd, Second, RoundNearestTiesUp) == NanoDate(yr, mn, dy, hr, mi, sc + (ms >= 500))
    @test round(nd, Millisecond, RoundNearestTiesUp) == NanoDate(yr, mn, dy, hr, mi, sc, ms + (cs >= 500))
    @test round(nd, Microsecond, RoundNearestTiesUp) == NanoDate(yr, mn, dy, hr, mi, sc, ms, cs + (ns >= 500))
    @test round(nd, Nanosecond, RoundNearestTiesUp) == NanoDate(yr, mn, dy, hr, mi, sc, ms, μs, ns)

end

@testset "subtract NanoDate"
    @test nd - DateTime(nd) == nd - NanoDate(DateTime(nd))
@test DateTime(nd) - nd == NanoDate(DateTime(nd)) - nd
    @test nd - Date(nd) == nd - NanoDate(Date(nd))
@test Date(nd) - nd == NanoDate(Date(nd)) - nd
end

@test nd - Time(nd) == nd - canonical(Time(nd))
        
end