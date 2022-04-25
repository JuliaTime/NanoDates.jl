## Converting NanoDates to Strings

The easiest way to obtain your NanoDate as a String is to use `string(nanodate)`.

```
using Dates, NanoDates

nd = nanonow()