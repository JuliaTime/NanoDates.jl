## Appealing Advantages

**NanoDates.jl integrates Nanoseconds into timekeeping and interoperates with many Julia packages.**

- Are your timestamp requirements more capable than `DateTime` supports?
- Does your application produce, consume, or otherwise ferry microtimed occurances?
- Is your masterful realtime design standing by as the nanoseconds fly away?

-----

- NanoDates are your fuller realization of dates-with-times.
- Each NanoDate is con*struct*ed within the temporal context given.
    - that makes them a strong and robust localized timekeeper 
- Full temporal resolution (all available periods) are shared for NanoDates and Times
    - "near" and "far" `(now(), now()+Month(2))` become
    - *first* and *final* 
        - `(nnow(Microsecond(35), nnow(Microsecond(35),Nanosecond(987))+Month(2))`
   
 -----
 
In 2018 finanical centers, through their host countries, adopted regulations that apply to organizations and individuals participating in the high frequency  trade-by-trade flow that gives rise to market microdynamics. Here are two quotes from the 2018 regulators:
 
 Market events and order transactions must be recorded
 [and] retraceable to UTC.
 
 Systems that are syncronized to a [validated network] clock, require timestamp availability at submillisecond resolutions. The shortest interval that is required of very high frequncy trading work is 25ns. 

----

*UTC is the timebase of record for statutory purposes and for most people as a shared convienience.*

