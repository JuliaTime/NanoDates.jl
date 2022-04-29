@testset "construction" begin
    @test DateTime(nd) == adatetime
    @test Date(nd) == adate
    @test Time(nd) == atime
end

@testset "conversion" begin
    @test convert(DateTime, nd) == adatetime
    @test convert(Date, nd) == adate
    @test convert(Time, nd) == atime
end


