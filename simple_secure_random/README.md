# Simple Secure Random

`SecureRandom` is Ruby's class for generating cryptographically secure random
numbers, hex, strings, base64 strings, UUIDs, etc. Your task is to implement as
much of `SecureRandom` as the module `SimpleSecureRandom` as you can in one hour.
You are not expected to be able to finish the task in the given time but if you
can, great!

## Rules:

- No gems
- No OpenSSL, you don't need it. Hint: Your OS provides all you need.
- Looking up docs is fine, looking at source code isn't
- 1 hour. Timeboxed

## Assessment criteria:

- Achieving a working solution
- The amount achieved at the end of the hour
- Writing automated tests and the quality of those tests
- Code quality
- Knowledge of Ruby
- Thought process, so please talk through what you're doing with the assessor

If you get stuck, please feel free to ask questions.

### SimpleSecureRandom.base64(n=nil)

::base64 generates a random base64 string.

The argument n specifies the length of the random length. The length of the result
string is about 4/3 of n.

If n is not specified, 16 is assumed. It may be larger in future.

The result may contain A-Z, a-z, 0-9, “+”, “/” and “=”.

```ruby
p SimpleSecureRandom.base64 #=> "/2BuBuLf3+WfSKyQbRcc/A=="
p SimpleSecureRandom.base64 #=> "6BbW0pxO0YENxn38HMUbcQ=="
```

See RFC 3548 for the definition of base64.

### SimpleSecureRandom.hex(n=nil)

::hex generates a random hex string.

The argument n specifies the length of the random length. The length of the result
string is twice of n.

If n is not specified, 16 is assumed. It may be larger in future.

The result may contain 0-9 and a-f.

```ruby
p SimpleSecureRandom.hex #=> "eb693ec8252cd630102fd0d0fb7c3485"
p SimpleSecureRandom.hex #=> "91dc3bfb4de5b11d029d376634589b61"
```

### SimpleSecureRandom.random_bytes(n=nil)

::random_bytes generates a random binary string.

The argument n specifies the length of the result string.

If n is not specified, 16 is assumed. It may be larger in future.

The result may contain any byte: “x00” - “xff”.

```ruby
p SimpleSecureRandom.random_bytes #=> "\xD8\\\xE0\xF4\r\xB2\xFC*WM\xFF\x83\x18\xF45\xB6"
p SimpleSecureRandom.random_bytes #=> "m\xDC\xFC/\a\x00Uf\xB2\xB2P\xBD\xFF6S\x97"
```

### SimpleSecureRandom.urlsafe_base64(n=nil, padding=false)

::urlsafe_base64 generates a random URL-safe base64 string.

The argument n specifies the length of the random length. The length of the result
string is about 4/3 of n.

If n is not specified, 16 is assumed. It may be larger in future.

The boolean argument padding specifies the padding. If it is false or nil, padding
is not generated. Otherwise padding is generated. By default, padding is not generated
because “=” may be used as a URL delimiter.

The result may contain A-Z, a-z, 0-9, “-” and “_”. “=” is also used if padding is true.

```ruby
p SimpleSecureRandom.urlsafe_base64 #=> "b4GOKm4pOYU_-BOXcrUGDg"
p SimpleSecureRandom.urlsafe_base64 #=> "UZLdOkzop70Ddx-IJR0ABg"

p SimpleSecureRandom.urlsafe_base64(nil, true) #=> "i0XQ-7gglIsHGV2_BNPrdQ=="
p SimpleSecureRandom.urlsafe_base64(nil, true) #=> "-M8rLhr7JEpJlqFGUMmOxg=="
```
See RFC 3548 for the definition of URL-safe base64.

### SimpleSecureRandom.uuid()

::uuid generates a v4 random UUID (Universally Unique IDentifier).

```ruby
p SimpleSecureRandom.uuid #=> "2d931510-d99f-494a-8c67-87feb05e1594"
p SimpleSecureRandom.uuid #=> "bad85eb9-0713-4da7-8d36-07a8e4b00eab"
p SimpleSecureRandom.uuid #=> "62936e70-1815-439b-bf89-8492855a7e6b"
```
The version 4 UUID is purely random (except the version). It doesn’t contain meaningful information such as MAC address, time, etc.

See RFC 4122 for details of UUID.
