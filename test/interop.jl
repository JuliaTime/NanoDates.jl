@testset "construction" begin
    @test DateTime(nd) == adatetime
    @test Date(nd) == dayt
    @test Time(nd) == tyme
end

@testset "conversion" begin
    @test convert(DateTime, nd) == adatetime
    @test convert(Date, nd) == dayt
    @test convert(Time, nd) == tyme
end

@testset "nanoseconds" begin
    ns = Dates.value(nd)
    nd2 = NanoDate(nd)
    @test nd == nd2
end
