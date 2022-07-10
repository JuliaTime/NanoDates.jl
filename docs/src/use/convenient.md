## Convenient Work-Alikes

Here are a few simple timesavers, DateTime work-alikes.
`ndnow(LOCAL)`, `ndnow(UTC)` are similar to `now()`, `now(UTC)`,
with support for microseconds and nanoseconds.

```
# ndnow(LOCAL), ndnow(UTC) work like now(), now(UTC)

now(UTC)                     # 1 millisecond resolution
# 2022-04-25T10:09:40.094

ndnow(LOCAL)                 # 100 nanosecond resolution (ymmv)
# 2022-04-25T10:09:40.094615300

ndnow(UTC, Microsecond(123), Nanosecond(0))
# 2022-04-25T10:09:40.094123

ndnow(LOCAL, Microsecond(123), Nanosecond(456))
# 2022-04-25T10:09:40.094123456
```

`ndtoday(UTC)` and `ndtoday(LOCAL)` are provided.
They work like today(), adding UTC, LOCAL.
```
ndtoday(UTC), ndtoday(LOCAL)
# 2022-04-26, 2022-04-25
```

