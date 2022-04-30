## The Representation

#### NanoDates are `structs` with two fields,

    One holds a value of type `DateTime`
    (containing Year, .., Millisecond periods).

    The other holds submillisecond information
    (containing Microseconds and Nanoseconds).
    This information is kept as a quantity of
    Nanoseconds, a quantity in 0..999_999.

    So, any Microseconds, and there may be 
    none or as many as 999 (no more though),
    are converted to their equivalant 
    duration in Nanoseconds (1_000 each)
    and the totality of time spanned
    is remains unchanged. These duration
    balancing Nanoseconds are added to
    any that are present already.
    
    All of the TimePeriod and the DatePeriod
    types are found in two distinct contexts.
    They are most familiar participating in
    specific clock and calendar designations.
 
    "Next year, school starts on Jan 4 at 9:15."
    "Let's meet for lunch at 12:15 today."

    That way of working with temporal periods relies
    on the attachment of periods to eventualities.
    Their other role occurs in a creative, rather
    than a descriptive context.  Periods exent,
    available and able, unfettered, nonassociated.

    "I will need at least 10 Nanoseconds to measure
     the effectiveness of Attosecond light pulses."
    "We should revisit this over coffee, monthly or better."

    That is the justification for holding extra nanoseconds.



    clock and calendar 
    is thier presence and utilization
    As free periods, periods not attached
    to a specific Time or any given Date,
    Nanoseconds are allowed to hold
    type to hold quantities exceeding
    their own field rollover count
    (the next nanosecond after
     the 999th carries all 1_000 of
     them into a single microsecond).
    
    And that lets us keep our struct
    to two fields while covering all
    Days of each Year one Nanosecond
    at a time.
