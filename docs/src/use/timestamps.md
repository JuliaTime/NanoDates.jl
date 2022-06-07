## Timestamps

#### `NanoDates` supports various timestamp formats.

----

#### ISO8061 UTC timestamp formats

|               timestamp                | resolution  | method(nd::NanoDate)                           |
|:---------------------------------------|:------------|:-----------------------------------------------|
| `2022-05-24T10:43:22Z`                 | second      | timestamp(floor(nd, Second); utc=true)         |
| `2022-05-24T10:43:22.350Z`             | millisecond | timestamp(floor(nd, Millisecond); utc=true)    |
| `2022-05-24T10:43:22.350789Z`          | microsecond | timestamp(floor(nd, Microsecond); utc=true)    |
| `2022-05-24T10:43:22.350789123Z`       | nanosecond  | timestamp(floor(nd, Nanosecond); utc=true)     |

#### ISO8061 local timestamp formats

|               timestamp                | resolution  | method(nd::NanoDate)                           |
|:---------------------------------------|:------------|:-----------------------------------------------|
| `2022-05-24T10:43:22-04:00`            | second      | timestamp(floor(nd, Second); localtime=true)       |
| `2022-05-24T10:43:22.350-04:00`        | millisecond | timestamp(floor(nd, Milliecond); localtime=true)   |
| `2022-05-24T10:43:22.350789-04:00`     | microsecond | timestamp(floor(nd, Microsecond); localtime=true)  |
| `2022-05-24T10:43:22.350789123-04:00`  | nanosecond  | timestamp(floor(nd, Nanosecond); localtime=true)   |

#### timestamp formats where no zone is specified

|               timestamp                | resolution  |  method(nd::NanoDate)             |
|:---------------------------------------|:------------|:----------------------------------|
| `2022-05-24T10:43:22`                  | second      | timestamp(floor(nd, Second))      |
| `2022-05-24T10:43:22.350`              | millisecond | timestamp(floor(nd, Millisecond)) |
| `2022-05-24T10:43:22.350789`           | microsecond | timestamp(floor(nd, Microsecond)) |
| `2022-05-24T10:43:22.350789123`        | nanosecond  | timestamp(nd)                     |
|                                        |             |                                   |
| `2022-05-24T10:43:22.350_789`          | microsecond | timestamp(floor(nd, Microsecond); sep=`_`) |
| `2022-05-24T10:43:22.350⬩789⬩123`      | nanosecond  | timestamp(nd; sep="⬩")                     |

#### timestamps that are counts offset from the UNIX Epoch (1970-01-01 UTC)

|               timestamp                | resolution  | method(nd::NanoDate)                |
|:---------------------------------------|:------------|:------------------------------------|
| `63789100018`                          | second      | nanodate2unixseconds(nd)            |
| `63789100018123`                       | millisecond | nanodate2unixmillis(nd)             |
| `63789100018123456`                    | microsecond | nanodate2unixmicros(nd)             |
| `63789100018⬩123⬩456⬩789`              | nanosecond  |  nanodate2unixnanos(nd; sep="⬩")    |


----

##### *to request another timestamp format, please raise an issue [here](https://github.com/JeffreySarnoff/NanoDates.jl/issues)*
