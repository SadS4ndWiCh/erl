# ping <=> pong

A simple Ping request with a POOR interprocess three-way handshake implementation.

```
+ ------ +                       + ------ +
| Client |                       | Server |
+ ------ +                       + ------ +
    ||                               ||
    || ----------- SYN ------------> ||
    ||             (M)               ||
    ||                               ||
    || <-------- SYN ACK ----------- ||
    ||           (M+1,N)             ||
    ||                               ||
    || ----------- ACK ------------> ||
    ||            (N+1)              ||
    ||                               ||
    || <-------- ACK ACK ----------- ||
    ||                               ||
    || ----------- PING -----------> ||
    || <---------- PONG ------------ ||
    ||                               ||
```
