@testset "construction" begin
    @test DateTime(nd) == daytetime
    @test Date(nd) == dayte
    @test Time(nd) == tyme
end

@testset "conversion" begin
    @test convert(DateTime, nd) == daytetime
    @test convert(Date, nd) == dayte
    @test convert(Time, nd) == tyme
end


