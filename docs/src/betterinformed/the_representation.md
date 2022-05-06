## Dates and Nanoseconds

## The Representation

#### NanoDates are `structs` with two fields,

One holds a value of type `DateTime` (containing Year, .., Millisecond periods).

The other holds submillisecond information (containing Microseconds and Nanoseconds). This information is kept as a quantity of Nanoseconds, a quantity in 0..999_999. So, any Microseconds, and there may be none or as many as 999 (no more though), are converted to their equivalant  duration in Nanoseconds (1_000 each) and the totality of time spanned is remains unchanged. These duration balancing Nanoseconds are added to any that are present already.
   

Being clock and calendar is their presence and the manner of their utilization.
As free periods, periods not attached to a specific Time or any given Date, Nanoseconds are allowed to hold type to hold quantities exceeding their own field rollover count (the next nanosecond after the 999th carries all 1_000 of them into a single microsecond). And that lets us keep our struct to two fields while covering all Days of each Year one Nanosecond at a time.
