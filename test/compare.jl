@testset "isequal" begin
    @test isequal(nd, nd)
    @test isequal(nd0, adatetime)
    @test isequal(adatetime, nd0)
    @test isequal(nd00, adate)
    @test isequal(adate, nd00)

    @test !isequal(nd, laternanodate)
    @test !isequal(nd, adatetime)
    @test !isequal(adatetime, nd)
    @test !isequal(nd, adate)
    @test !isequal(adate, nd)
end

@testset "isless" begin
    @test isless(nd, laternanodate)
    @test isless(nd, laterdatetime)
    @test isless(nd, laterdate)
    @test isless(earlierdatetime, nd)
    @test isless(earlierdate, nd)
end

@testset "(==, !=)" begin
    @test ==(nd, nd)
    @test ==(nd0, adatetime)
    @test ==(adatetime, nd0)
    @test ==(nd00, adate)
    @test ==(adate, nd00)

    @test !=(nd, laternanodate)
    @test !=(nd, adatetime)
    @test !=(adatetime, nd)
    @test !=(nd, adate)
    @test !=(adate, nd)
end

@testset "(<, >=)" begin
    @test <(nd, laternanodate)
    @test <(nd, laterdatetime)
    @test <(nd, laterdate)
    @test <(earlierdatetime, nd)
    @test <(earlierdate, nd)

    @test >=(laternanodate, nd)
    @test >=(laterdatetime, nd)
    @test >=(laterdate, nd)
    @test >=(nd, earlierdatetime)
    @test >=(nd, earlierdate)

    @test >=(nd, nd)
    @test >=(nd0, adatetime)
    @test >=(adatetime, nd0)
    @test >=(nd00, adate)
    @test >=(adate, nd00)
end

@testset "(>, <=)" begin
    @test >(laternanodate, nd)
    @test >(laterdatetime, nd)
    @test >(laterdate, nd)
    @test >(nd, earlierdatetime)
    @test >(nd, earlierdate)

    @test <=(nd, laternanodate)
    @test <=(nd, laterdatetime)
    @test <=(nd, laterdate)
    @test <=(earlierdatetime, nd)
    @test <=(earlierdate, nd)

    @test <=(nd, nd)
    @test <=(nd0, adatetime)
    @test <=(adatetime, nd0)
    @test <=(nd00, adate)
    @test <=(adate, nd00)
end
