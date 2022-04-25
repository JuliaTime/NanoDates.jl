@testset "isequal" begin
    @test isequal(ananodate, ananodate)
    @test isequal(ananodate0, adatetime)
    @test isequal(adatetime, ananodate0)
    @test isequal(ananodate00, adate)
    @test isequal(adate, ananodate00)

    @test !isequal(ananodate, laternanodate)
    @test !isequal(ananodate, adatetime)
    @test !isequal(adatetime, ananodate)
    @test !isequal(ananodate, adate)
    @test !isequal(adate, ananodate)
end

@testset "isless" begin
    @test isless(ananodate, laternanodate)
    @test isless(ananodate, laterdatetime)
    @test isless(ananodate, laterdate)
    @test isless(earlierdatetime, ananodate)
    @test isless(earlierdate, ananodate)
end

@testset "(==, !=)" begin
    @test ==(ananodate, ananodate)
    @test ==(ananodate0, adatetime)
    @test ==(adatetime, ananodate0)
    @test ==(ananodate00, adate)
    @test ==(adate, ananodate00)

    @test !=(ananodate, laternanodate)
    @test !=(ananodate, adatetime)
    @test !=(adatetime, ananodate)
    @test !=(ananodate, adate)
    @test !=(adate, ananodate)
end

@testset "(<, >=)" begin
    @test <(ananodate, laternanodate)
    @test <(ananodate, laterdatetime)
    @test <(ananodate, laterdate)
    @test <(earlierdatetime, ananodate)
    @test <(earlierdate, ananodate)

    @test >=(laternanodate, ananodate)
    @test >=(laterdatetime, ananodate)
    @test >=(laterdate, ananodate)
    @test >=(ananodate, earlierdatetime)
    @test >=(ananodate, earlierdate)

    @test >=(ananodate, ananodate)
    @test >=(ananodate0, adatetime)
    @test >=(adatetime, ananodate0)
    @test >=(ananodate00, adate)
    @test >=(adate, ananodate00)
end

@testset "(>, <=)" begin
    @test >(laternanodate, ananodate)
    @test >(laterdatetime, ananodate)
    @test >(laterdate, ananodate)
    @test >(ananodate, earlierdatetime)
    @test >(ananodate, earlierdate)

    @test <=(ananodate, laternanodate)
    @test <=(ananodate, laterdatetime)
    @test <=(ananodate, laterdate)
    @test <=(earlierdatetime, ananodate)
    @test <=(earlierdate, ananodate)

    @test <=(ananodate, ananodate)
    @test <=(ananodate0, adatetime)
    @test <=(adatetime, ananodate0)
    @test <=(ananodate00, adate)
    @test <=(adate, ananodate00)
end
