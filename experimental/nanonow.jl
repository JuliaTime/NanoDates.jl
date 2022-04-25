const u3 = UInt32(1_000)
const u6 = UInt32(1_000_000)
const u9 = UInt32(1_000_000_000)

@inline millisecond_ns() = div(rem(time_ns(), u9), u6) 

@inline millisecond_offset() = mod(value(now())%UInt64, u3) - millisecond_ns()

@inline millisecond_ns(tm) = div(rem(tm, u9), u6) 

@inline millisecond_offset(tm, dtm) = mod(value(dtm)%UInt64, u3) - millisecond_ns(tm)

@inline function more_precise()
    tm, dtm = time_ns(), Dates.value(now())%UInt64
    tm_csns = mod(tm, u6)
    # milli_offset = millisecond_offset(tm, dtm)
    NanoDate(DateTime(Dates.UTM(dtm)), Nanosecond(tm_csns))
end

value(now()) * 1_000 - rem(time_ns(), u6)

@inline dynmicoffset() = mod( time_ns(), 60_000_000_000), mod(value(now()), 60_000) * 1_000_000

@inline offset(ns,dtm) = 
    mod(ns, 60_000_000_000), mod(dtm, 60_000) * 1_000_000


function offset_reset()
    tmns0, tm0 = time_ns(), time()
    tmns = Int128(tmns0)
    tm = trunc(Int128, tm0 * Int128(1_000_000))
    toffset = tmns - tm
    offset_csns = mod(toffset, 1_000_000)
    dtm = DateTime(Dates.UTM(Millisecond(div(tm, 1_000))))
    csns = Nanosecond(offset_csns)
    NanoDate(dtm, offset_csns)
end


