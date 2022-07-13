function Base.show(io::IO, nd::NanoDate; sep::CharString="")
    str = string(nd; sep)
    print(io, str)
end

function Base.show(io::IO, nd::NanoDate,
                    df::DateFormat; sep::CharString="")
    str = Dates.format(nd, df; sep)
    print(io, str)
end

Base.show(io::IO, m::MIME"text/plain", nd::NanoDate) =
    print(io, string(nd))

Base.show(io::IO, m::MIME"text/plain", nd::NanoDate, sep::Char) = 
    print(io, string(nd; sep))
