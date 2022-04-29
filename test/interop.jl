@testset "construction" begin
    @test DateTime(nd) == daytime
    @test Date(nd) == dayte
    @test Time(nd) == tyme
end

@testset "conversion" begin
    @test convert(DateTime, nd) == daytime
    @test convert(Date, nd) == dayte
    @test convert(Time, nd) == tyme
end


