## Convenient Work-Alikes

Here are a few simple timesavers, DateTime work-alikes.
`ndnow(LOCAL)`, `ndnow(UTC)` are similar to `now()`, `now(UTC)`,
with support for microseconds and nanoseconds.

```
# ndnow(LOCAL), ndnow(UTC) work like now(), now(UTC)

now(UTC)                     # 1 millisecond resolution
# 2022-06-18T12:15:30.123

ndnow(LOCAL)                 # 100 nanosecond resolution (ymmv)
# 2022-06-18T12:15:30.123456700

ndnow(UTC, Microsecond(321), Nanosecond(0))
# 2022-06-18T12:15:30.123321

ndnow(LOCAL, Microsecond(321), Nanosecond(555))
# 2022-06-18T12:15:30.12332555
```

`ndtoday(UTC)` and `ndtoday(LOCAL)` are provided.
They work like today(), adding UTC, LOCAL.
```
ndtoday(UTC), ndtoday(LOCAL)
# 2022-04-26, 2022-04-25
```

