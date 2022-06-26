# uses ReadableRegex.jl

#=
digits_after_dotᵣₓ =  @compile look_for( 
    one_or_more(DIGIT), after = '.', as="digits_after_dots" )
=#

maybe_digits = @compile capture(look_for(
    maybe(one_or_more(DIGIT))
), as="digits_maybe")

maybe_digits_after_dot = @compile  capture(look_for(
    maybe(one_or_more(DIGIT)), after=exactly(1,'.')
), as="digits_after_dot_maybe") 

maybe_digits_after_underscore = @compile  capture(look_for(
    maybe(one_or_more(DIGIT)), after=exactly(1,'_')
), as="digits_after_underscore_maybe") 

maybe_digits_after_underscores = @compile  capture(look_for(
    maybe(one_or_more(DIGIT)), after=look_for(exactly(1,'_'), after=exactly(1,'_'))
), as="digits_after_underscores_maybe") 

digits_after_uscore = @compile  capture(look_for(
    one_or_more(DIGIT), after=exactly(1,'_')
))    


    look_for(
    one_or_more(DIGIT), after=exactly(1,'_')

)


period_digits_uscore = @compile  capture(l
ook_for(
    one_or_more(DIGIT), after=exactly(1,'_'), before =exactly(1,'_')
))

uscore_digits_uscore = @compile  capture(look_for(
    one_or_more(DIGIT), after=exactly(1,'_'), before =exactly(1,'_')
))

uscore_digits_uscore = @compile  capture(look_for(
    one_or_more(DIGIT), after=exactly(1,'_'), before =exactly(1,'_')
))

digits_after_uscore_digits_uscore = @compile  capture(look_for(
    one_or_more(DIGIT), after=look_for(exactly(1,'_'), one_or_more(DIGIT), before =exactly(1,'_')
))

digits_after_dotᵣₓ =  @compile  capture(look_for( 
    one_or_more(DIGIT), after = exactly(1,'.')), 
    as="digits_after_dot" )

digits_after_uscoreᵣₓ =  @compile  capture(look_for( 
    one_or_more(DIGIT), after = exactly(1,'_')), 
    as="digits_after_uscore" )

digits_after_twouscoreᵣₓ =  @compile  capture(look_for( 
    one_or_more(DIGIT), after = exactly(1,'_') ), 
    as="digits_after_uscore" )


    digits_before_uscoreᵣₓ =  @compile  capture(look_for( 
    one_or_more(DIGIT), after = exactly(1,'_')), 
    as="digits_after_uscore" )

    dot_digitsᵣₓ =  @compile  capture(look_for( 
    one_or_more(DIGIT), after = '.'), 
    as="digits_after_dots" )

    capture_digits_afterdotᵣₓ = capture(digits_after_dotᵣₓ)

named_capture_digits_afterdotᵣₓ = capture(digits_after_dotᵣₓ, as="(dot)digs")



subseconds_afterdot_ᵣₓ = @compile lookfor(
    oneormore(DIGIT), after='.'
)

subseconds_aftercomma_ᵣₓ = @compile lookfor(
    oneormore(DIGIT), after=','
)

subseconds_underscored_ᵣₓ = @compile look_for(
    capture(one_or_more(DIGIT), after='.'; as=:millis) * 
    capture(one_or_more(DIGIT), after='_'; as=:micros) *
    capture(one_or_more(DIGIT), after='_'; as=:nanos))

subseconds_underscored_ᵣₓ = @compile lookfor(
    capture(one_or_more(DIGIT), after='_') )

subseconds_commasep_ᵣₓ