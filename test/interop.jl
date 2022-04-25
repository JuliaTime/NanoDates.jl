@testset "construction" begin
    @test DateTime(ananodate) == adatetime
    @test Date(ananodate) == adate
    @test Time(ananodate) == atime
end

@testset "conversion" begin
    @test convert(DateTime, ananodate) == adatetime
    @test convert(Date, ananodate) == adate
    @test convert(Time, ananodate) == atime
end


