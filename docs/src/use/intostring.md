## Converting NanoDates and Strings

##### To obtain your NanoDate as a String is to use `string(nanodate)`.

```
using Dates, NanoDates

adatetime = DateTime(2022,06,18,12,15,30);
subsecond = Nanosecond(123_456_789);

nd = NanoDate(adatetime, subsecond)
# 2022-06-18T12:15:30.123456789

string(nd)  # "2022-06-18T12:15:30.123456789"
```

##### Use `timestamp` to get an ISO8061 conoforming string.
```
timestamp(nd; utc=true)
# "2022-06-18T12:15:30.123456789Z"

timestamp(nd; localtime=true)
# "2022-06-18T12:15:30.123456789-04:00"
```

##### Accepting ISO8061 conforming strings does not require dateformat.
```
NanoDate("2022-06-18T12:15:30.123456789Z")
# 2022-06-18T12:15:30.123456789

NanoDate("2022-06-18T12:15:30.123456-04:00")
# 2022-05-18T12:15:30.123456
```

##### Accepting strings that are not ISO8061 conforming requires a dateformat.
```
NanoDate("-- 12345 2022-06-18 12:15:30", 
         dateformat"-- sssss yyyy-mm-dd HH:MM:SS")
# 2022-06-18T12:15:30.123450
```

##### More easily readable is `string(nanodate; sep='<choose a Char>' )`.

```
string(nd; sep='_')
# "2022-06-18T12:15:30.123_456_789"

string(nd; sep='◦')
# "2022-06-18T12:15:30.123◦456◦789"
```
