## Timestamps

`NanoDates` supports these ISO8061 timestamp formats

|               timestamp                | resolution  | zone   | method(nd::NanoDate)                           |
|----------------------------------------|-------------|--------|:-----------------------------------------------|
| `2022-05-24T10:43:22Z`                 | second      | UTC    | timestamp(floor(nd, Second); utc=true)         |
| `2022-05-24T10:43:22.350Z`             | millisecond | UTC    | timestamp(floor(nd, Millisecond); utc=true)    |
| `2022-05-24T10:43:22.350789Z`          | microsecond | UTC    | timestamp(floor(nd, Microsecond); utc=true)    |
| `2022-05-24T10:43:22.350789123Z`       | nanosecond  | UTC    | timestamp(floor(nd, Nanosecond); utc=true)     |
|                                        |             |        |                                                |
| `2022-05-24T10:43:22-04:00`            | second      | local  | timestamp(floor(nd, Second); local=true)       |
| `2022-05-24T10:43:22.350-04:00`        | millisecond | local  | timestamp(floor(nd, Milliecond); local=true)   |
| `2022-05-24T10:43:22.350789-04:00`     | microsecond | local  | timestamp(floor(nd, Microsecond); local=true)  |
| `2022-05-24T10:43:22.350789123-04:00`  | nanosecond  | local  | timestamp(floor(nd, Nanosecond); local=true)   |

`NanoDates` supports these additional timestamp formats

|               timestamp                | resolution  | offset from  |  method(nd::NanoDate)             |
|----------------------------------------|-------------|--------------|:----------------------------------|
| `2022-05-24T10:43:22`                  | second      | unspecified  | timestamp(floor(nd, Second))      |
| `2022-05-24T10:43:22.350`              | millisecond | unspecified  | timestamp(floor(nd, Millisecond)) |
| `2022-05-24T10:43:22.350789`           | microsecond | unspecified  | timestamp(floor(nd, Microsecond)) |
| `2022-05-24T10:43:22.350789123`        | nanosecond  | unspecified  | timestamp(nd)                     |
|                                        |             |              |                                   |
| `2022-05-24T10:43:22.350_789`          | microsecond | unspecified  | timestamp(floor(nd, Microsecond); sep=`_`) |
| `2022-05-24T10:43:22.350⬩789⬩123`      | nanosecond  | unspecified  | timestamp(nd; sep="⬩")                     |
|                                        |             |              |                                            |
| `63789100018`                          | second      | UNIX Epoch   | nanodate2unixseconds(nd)           |
| `63789100018123`                       | millisecond | UNIX Epoch   | nanodate2unixmillis(nd)            |
| `63789100018123456`                    | microsecond | UNIX Epoch   | nanodate2unixmicros(nd)            |
| `63789100018⬩123⬩456⬩789`              | nanosecond  | UNIX Epoch   | nanodate2unixnanos(nd; sep="⬩")    |
|                                        |             |              |

----

##### *to request another timestamp format, please raise an issue [here](https://github.com/JeffreySarnoff/NanoDates.jl/issues)*
