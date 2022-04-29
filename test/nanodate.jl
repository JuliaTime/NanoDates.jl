@testset "construct by periods" begin
    @test NanoDate(yr,mn,dy,hr,mi,sc,ms,cs,ns) == nd
    @test NanoDate(Yr,Mn,Dy,Hr,Mi,Sc,Ms,Cs,Ns) == nd
    @test NanoDate(yr,mn,dy,hr,mi,sc,ms) == nd0
    @test NanoDate(Yr,Mn,Dy,Hr,Mi,Sc,Ms) == nd0
    @test NanoDate(yr,mn,dy) == nd00
    @test NanoDate(Yr,Mn,Dy) == nd00 
end

@testset "construct by Dates types" begin
    @test NanoDate(dayte, tyme) == nd
    @test NanoDate(daytetime, ananosecs) == nd
    @test NanoDate(daytetime) == nd0
    @test NanoDate(dayte) == nd00
end



    
