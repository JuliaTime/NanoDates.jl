Base.promote_rule(::Type{NanoDate}, ::Type{DateTime}) = NanoDate
Base.promote_rule(::Type{NanoDate}, ::Type{Date}) = NanoDate

