## Conveniences

Here are a few simple timesavers, DateTime work-alikes.

```
# nanonow(), nanonow(UTC) work like now(), now(UTC)

julia> now(UTC)                     # 1 millisecond resolution
2022-04-25T10:09:40.094

julia> nanonow(UTC)                 # 100 nanosecond resolution (ymmv)
2022-04-25T10:09:40.094615300

# nanotoday() nanotoday(UTC) works like today(), adds today(UTC)

julia> today()
2022-04-25

julia> nanonow(), nanotoday()
2022-04-25T22:33:44, 2022-04-25

julia> nanotoday(UTC)
2022-04-26