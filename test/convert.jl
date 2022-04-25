@testset "convert" begin
    @test convert(NanoDate, adatetime) == ananodate0
    @test convert(NanoDate, adate) == ananodate00
end

@testset "promote" begin
    @test promote(ananodate, adatetime) = (ananodate, NanoDate(adatetime))
    @test promote(ananodate, adate) = (ananodate, NanoDate(adate))
end

