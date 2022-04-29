## Convenient Work-Alikes

Here are a few simple timesavers, DateTime work-alikes.
`nnow()`, `nnow(UTC)` are similar to `now()`, `now(UTC)`,
with support for specifying microseconds and nanoseconds.

```
# nnow(), nnow(UTC) work like now(), now(UTC)

now()                        # 1 millisecond resolution
# 2022-04-25T10:09:40.094

nnow()                       # 100 nanosecond resolution (ymmv)
# 2022-04-25T10:09:40.094615300
```
These additional forms are available.
```
nnow(Microsecond(cs)), nnow(UTC, Microsecond(ns)),
nnow(Nanosecond(cs)),  nnow(UTC, Nanosecond(ns))

nnow(Microsecond(cs), Nanosecond(ns)),
nnow(UTC, Microsecond(cs), Nanosecond(ns))
```

`ntoday()` and `ntoday(UTC)` are provided.
They work like today(), adding UTC.
```
today()
# 2022-04-25

ntoday(), ntoday(UTC)
# 2022-04-25, 2022-04-26
```

