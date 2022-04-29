## Converting NanoDates to Strings

The easiest way to obtain your NanoDate as a String is to use `string(nanodate)`.
Similarly easy, and more readable is `string(nanodate; sep='<choose a Char>' )`.

```
using Dates, NanoDates

nd = NanoDate(DateTime("2022-07-28T12:15:30.118"), Nanosecond(375852))
# 2022-07-28T12:15:30.118375852

string(nd)
# "2022-07-28T12:15:30.118375852"

string(nd; sep='_')
# "2022-07-28T12:15:30.118_375_852"

string(nd; sep='◦')
# "2022-07-28T12:15:30.118◦375◦852"

string(nd; sep='∙')
# "2022-07-28T12:15:30.118∙375∙852"
```
