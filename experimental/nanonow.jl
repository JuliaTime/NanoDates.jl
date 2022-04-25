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


Dates.value(now()) - Dates.value(DateTime(1970,1,1))
1650886367654


julia> Dates.value(now()) - Dates.value(DateTime(1970,1,1))
1650886434679
julia> round(Int,time()*1_000)
1650900835774

const UNIXEPOCH_MILLISECONDS = Dates.value(DateTime(1970,1,1))

# this value is match to Int(time() * 1_000)
@inline datetime2unixmilliseconds(dtm) = Dates.value(dtm) - UNIXEPOCH_MILLISECONDS
@inline time2unixmilliseconds(tm) = trunc(Int, tm * 1_000)

@inline datetime2unixnanoseconds(dtm) = datetime2unixmilliseconds(dtm)
@inline time2unixnanoseconds(tm) = time2unixmilliseconds(tm) * 1_000_000

tm, ns, dtm = time(), time_ns(), now()
datetime2unixnanoseconds(dtm) - time2unixnanoseconds(tm)

datetime2unixnanoseconds(dtm) - ns


julia> datetime2unixnanoseconds(dtm) - ns
0xfffee566434df922

julia> ~ans
0x00011a99bcb206dd

julia> canonicalize(Nanosecond(ans))
3 days, 14 hours, 18 minutes, 42 seconds, 574 milliseconds, 812 microseconds, 893 nanoseconds

julia> tm, ns, dtm = time(), time_ns(), now()
(1.650901633654e9, 0x00011c26a6d5a054, DateTime("2022-04-25T11:47:13.654"))

datetime2unixnanoseconds(dtm) - time2unixnanoseconds(tm)

julia> datetime2unixnanoseconds(dtm) - ns
0xfffee559b9b67022

julia> ~ans
0x00011aa646498fdd

julia> canonicalize(Nanosecond(ans))
3 days, 14 hours, 19 minutes, 36 seconds, 422 milliseconds, 830 microseconds, 45 nanoseconds


julia> datetime2unixnanoseconds(dtm) - ns
0xfffee559b9b67022

julia> d=~ans
0x00011aa646498fdd

julia> di=Int(d)
310776422830045

