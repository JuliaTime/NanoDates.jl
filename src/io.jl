function Base.show(io::IO, nd::NanoDate; sep::CharString="")
    str = string(nd; sep)
    print(io, str)
end

function Base.show(io::IO, nd::NanoDate, df::DateFormat; sep::CharString="")
    str = Dates.format(nd, df; sep)
    print(io, str)
end


# this is used to handle a call to `print`
Base.show(io::IO, nd::NanoDate) = print(io, string(nd))

# this is used to show values in the REPL and when using IJulia
Base.show(io::IO, m::MIME"text/plain", nd::NanoDate) = print(io, string(nd))
