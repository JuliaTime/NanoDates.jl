# noticed something similar in Boost datetime

struct WrappingPaper{T} <: Signed
    minval::T  # minval - 1 == maxval
    maxval::T  # maxval + 1 == minval
    nvals::T   # maxval - minval + 1
end

function WrappingPaper(minval, maxval)
    minval, maxval = minmax(minval, maxval)
    nvals = maxval - minval + 1
    WrappingPaper(minval, maxval, nvals)
end

WrappingPaper(x::WrappingPaper) = x

function Base.show(io::IO, x::WrappingPaper)
    nt = (minval=x.minval, maxval=x.maxval, nvals=x.nvals)
    print(io, string(nt))
end

months28days = WrappingPaper(1, 28)
months29days = WrappingPaper(1, 29)
months30days = WrappingPaper(1, 30)
months31days = WrappingPaper(1, 31)

mutable struct WrappingInt{T} <: Signed
    x::T
    minval::T
    maxval::T
end

function WrappingInt(x::T, wp::WrappingPaper{T}) where {T}
    WrappingInt(x, wp.minval, wp.maxval)
end

