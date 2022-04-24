using Dates, NanoDates, Test
using NanoDates: datedatetime, nanosecs

yr,mn,dy = (2022, 7, 28)
hr,mi,sc = (10, 20, 0)
ms,us,ns = (350, 789, 420)

Yr,Mn,Dy = Year(yr), Month(mn), Day(dy)
Hr,Mi,Sc = Hour(hr), Minute(mi), Second(sc)
Ms,Us,Ns = Millisecond(ms), Microsecond(us), Nanosecond(ns)

date = Date(yr, mn, dy)
time = Time(hr, mi, sc, ms, us, ns)
nanos = nanosecs(Microsecond(time), Nanosecond(time))
datetime = DateTime(date, trunc(time, Millisecond))
nanodate = NanoDate(datetime, nanos)

@testset "constructors" begin
    @test_throws MethodError NanoDate()
    
    @test nanodate.datetime == datetime
    @test nanodate.nanosecs == nanos

    @test NanoDate(date, time) == nanodate
    @test NanoDate(yr, mn, dy) == NanoDate(date)
    @test NanoDate(Yr, Mn, Dy) == NanoDate(date)
    @test NanoDate(yr, mn, dy, hr, mi, sc, ms, us, ns) == nanodate
    @test NanoDate(Yr, Mn, Dy, Hr, Mi, Sc, Ms, Us, Ns) == nanodate
end
