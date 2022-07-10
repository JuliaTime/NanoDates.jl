## Converting NanoDates and Strings

##### To obtain your NanoDate as a String is to use `string(nanodate)`.

```
using Dates, NanoDates

nd = NanoDate(DateTime("2022-07-28T12:15:30.118"),
              Nanosecond(375852));

string(nd)
"2022-07-28T12:15:30.118375852"
```

##### Use `timestamp` to get an ISO8061 conoforming string.
```
timestamp(nd; utc=true)
"2022-07-28T12:15:30.118375852Z"

timestamp(nd; localtime=true)
"2022-07-28T12:15:30.118375852-04:00"
```

##### More easily readable is `string(nanodate; sep='<choose a Char>' )`.

```
string(nd; sep='_')
"2022-07-28T12:15:30.118_375_852"

string(nd; sep='◦')
"2022-07-28T12:15:30.118◦375◦852"
```

##### Accepting ISO8061 conforming strings does not require dateformat.
```
NanoDate("2022-07-28T12:15:30.118375852Z")
2022-07-28T12:15:30.118375852

NanoDate("2022-07-28T12:15:30.118375-04:00")
2022-07-28T12:15:30.118375
```

##### Accepting strings that are not ISO8061 conforming requires a dateformat.
```
NanoDate("-- 12345 2022-06-18 12:15:30", 
         dateformat"-- sssss yyyy-mm-dd HH:MM:SS")
2022-06-18T12:15:30.123450
```
