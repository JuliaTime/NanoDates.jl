## Timestamps

#### `NanoDates` supports various timestamp formats.

----

#### ISO8061 UTC timestamp formats (the default)

|               timestamp                | method(nd::NanoDate)                           |
|:---------------------------------------|:-----------------------------------------------|
| `2022-05-24T10:43:22Z`                 | timestamp(floor(nd, Second); utc=true)         |
| `2022-05-24T10:43:22.350Z`             | timestamp(floor(nd, Millisecond); utc=true)    |
| `2022-05-24T10:43:22.350789Z`          | timestamp(floor(nd, Microsecond); utc=true)    |
| `2022-05-24T10:43:22.350789123Z`       | timestamp(floor(nd, Nanosecond); utc=true)     |

#### ISO8061 local timestamp formats

|               timestamp                | method(nd::NanoDate)                           |
|:---------------------------------------|:-----------------------------------------------|
| `2022-05-24T10:43:22-04:00`            | timestamp(floor(nd, Second); localtime=true)       |
| `2022-05-24T10:43:22.350-04:00`        | timestamp(floor(nd, Millisecond); localtime=true)   |
| `2022-05-24T10:43:22.350789-04:00`     | timestamp(floor(nd, Microsecond); localtime=true)  |
| `2022-05-24T10:43:22.350789123-04:00`  | timestamp(floor(nd, Nanosecond); localtime=true)   |

#### variant UTC timestamp (omits the Z)

|               timestamp                | method(nd::NanoDate)                           |
|:---------------------------------------|-----------------------------------------------|
| `2022-05-24T10:43:22`                 | timestamp(floor(nd, Second); utc=true, postfix=false)         |
| `2022-05-24T10:43:22.350`             | timestamp(floor(nd, Millisecond); utc=true, postfix=false)    |
| `2022-05-24T10:43:22.350789`          | timestamp(floor(nd, Microsecond); utc=true, postfix=false)    |
| `2022-05-24T10:43:22.350789123`       | timestamp(floor(nd, Nanosecond); utc=true, postfix=false)     |

#### variant local timestamp (adjusts for offset)

|               timestamp                | method(nd::NanoDate)                           |
|:---------------------------------------|:-----------------------------------------------|
| `2022-05-24T06:43:22`            | timestamp(floor(nd, Second); localtime=true, postfix=false)       |
| `2022-05-24T06:43:22.350`        | timestamp(floor(nd, Millisecond); localtime=true, postfix=false)   |
| `2022-05-24T06:43:22.350789`     | timestamp(floor(nd, Microsecond); localtime=true, postfix=false)  |
| `2022-05-24T06:43:22.350789123`  | timestamp(floor(nd, Nanosecond); localtime=true, postfix=false)   |


#### timestamp formats where no zone is specified

|               timestamp                |  method(nd::NanoDate)             |
|:---------------------------------------|:----------------------------------|
| `2022-05-24T10:43:22`                  | timestamp(floor(nd, Second))      |
| `2022-05-24T10:43:22.350`              | timestamp(floor(nd, Millisecond)) |
| `2022-05-24T10:43:22.350789`           | timestamp(floor(nd, Microsecond)) |
| `2022-05-24T10:43:22.350789123`        | timestamp(nd)                     |

#### timestamps with subsecond separators (other options still available)
|               timestamp                |  method(nd::NanoDate)             |
|:---------------------------------------|:----------------------------------|
| `2022-05-24T10:43:22.350_789`          | timestamp(floor(nd, Microsecond); sep=`_`) |
| `2022-05-24T10:43:22.350⬩789⬩123`      | timestamp(nd; sep="⬩")                     |

#### timestamps that are counts offset from the UNIX Epoch (1970-01-01 UTC)

|               timestamp                | resolution  | method(nd::NanoDate)                |
|:---------------------------------------|:------------|:------------------------------------|
| `63789100018`                          | second      | nanodate2unixseconds(nd)            |
| `63789100018123`                       | millisecond | nanodate2unixmillis(nd)             |
| `63789100018123456`                    | microsecond | nanodate2unixmicros(nd)             |

----

##### *to request another timestamp format, please raise an issue [here](https://github.com/JeffreySarnoff/NanoDates.jl/issues)*
