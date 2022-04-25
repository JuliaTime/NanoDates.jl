Base.promote_rule(::Type{NanoDate}, ::Type{DateTIme}) = NanoDate
Base.promote_rule(::Type{NanoDate}, ::Type{Date}) = NanoDate

