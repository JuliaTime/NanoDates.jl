@testset "construction" begin
    @test DateTime(nd) == daytime
    @test Date(nd) == dayt
    @test Time(nd) == tyme
end

@testset "conversion" begin
    @test convert(DateTime, nd) == daytime
    @test convert(Date, nd) == dayt
    @test convert(Time, nd) == tyme
end


