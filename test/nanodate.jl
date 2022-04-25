@testset "construct by periods" begin
    @test NanoDate(yr,mo,dy,hr,mi,sc,ms,cs,ns) == ananodate
    @test NanoDate(Yr,Mo,Dy,Hr,Mi,Sc,Ms,Cs,Ns) == ananodate
    @test NanoDate(yr,mo,dy,hr,mi,sc,ms) == ananodate0
    @test NanoDate(Yr,Mo,Dy,Hr,Mi,Sc,Ms) == ananodate0
    @test NanoDate(yr,mo,dy) == ananodate00
    @test NanoDate(Yr,Mo,Dy) == ananodate00 
end

@testset "construct by Dates types" begin
    @test NanoDate(adate, atime) == ananodate
    @test NanoDate(adatetime, ananosec) == ananodate
    @test NanoDate(adatetime) == ananodate0
    @test NanoDate(adate) == ananodate00

    @test convert(NanoDate, adatetime) == ananodate0
    @test convert(NanoDate, adate) == ananodate00
end


    
