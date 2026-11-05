import std/math
import std/strutils
import std/options

# Characters and Strings
let singleChar: char = 'A' # Single quotes only for char
let normalStr: string = "Hi" # Double quotes for strings
let rawStr = r"C:\Users\nim" # Raw string literal (ignores escape characters)

# Set type (can hold elements of ordinal types, up to 2^16 elements)
type CharSet = set[char]
var vowelSet: CharSet = {'a', 'e', 'i', 'o', 'u'}

var age: int = 20
var name = "fh"

var
  x = 10
  y = 30

const pi = 3.143

var list: array[3, int] = [10, 20, 20]
var dynamicList: seq[string] = @["a", "f", "o"]

var user: tuple[name: string, age: int] = (name: "bob", age: 26)

let a = 10
let b = 3

echo a + b # 13  (Addition)
echo a - b # 7   (Subtraction)
echo a * b # 30  (Multiplication)
echo a / b # 3.333333333333333 (Float Division - ALWAYS returns a float)
echo a div b # 3   (Integer Division - drops the remainder)
echo a mod b # 1   (Modulo / Remainder)
echo a ^ b # Performs exponentiation (1000)

# Explicit Type Conversion
let xInt = 5
let yFloat = 2.5
echo xInt.float + yFloat # 7.5 (Must convert int to float explicitly)

# Comparisons: ==, !=, <, >, <=, >=
echo 5 != 3 # true

# Logical Operations (Uses clean English words instead of symbols)
echo true and false # false
echo true or false # true
echo not true # false

# bitwise operators
let flagA: uint8 = 0b0000_1100 # 12
let flagB: uint8 = 0b0000_1010 # 10

echo flagA and flagB # 0b0000_1000 (Bitwise AND)
echo flagA or flagB # 0b0000_1110 (Bitwise OR)
echo flagA xor flagB # 0b0000_0110 (Bitwise XOR)
echo not flagA # 0b1111_0011 (Bitwise NOT)
echo flagA shl 2 # Bitwise Shift Left
echo flagA shr 1 # Bitwise Shift Right

# Concatenation operator is `&` (not `+`)
let firstName = "Nim"
let lastName = "Lang"
echo firstName & " " & lastName # "Nim Lang"

# Inclusion operators for sets and sequences
let mySet = {1, 2, 3}
echo 2 in mySet # true
echo 5 notin mySet # true

# if/elif/else
let score = 90
if score >= 90:
  echo "A"
elif score >= 80:
  echo "B"
else:
  echo "F"

# case
case score
of 90 .. 100:
  echo "suberb"
of 80 .. 89:
  echo "good"
# Fixed overlap
else:
  echo "trial"

# loops
for i in 1 .. 5: # inclusive
  echo i

for item in dynamicList:
  echo item

# while
var count = 0
while count < 3: # Fixed indentation
  echo count
  inc(count)

let items = @["apples", "bananas", "cherry"]
for index, fruit in items:
  echo index, ": ", fruit

# procedures
proc greet(name: string): string =
  result = "yoh " & name # Added missing space inside the string

echo greet("world") # Fixed order (echo greet("world") or "world".greet.echo)
"world".greet.echo

proc addNum(a: int, b: int): int =
  result = a + b

echo addNum(5, 10)
echo addNum(6, 4) # Fixed missing second parameter

# objects
type Person = object
  name: string
  age: int

let ananymousPerson = Person(name: "yu", age: 54)

type User* = object
  name*: string
  age*: int
  secretId: string # Fixed typo "secerId"

var player1 = User(name: "er", age: 18, secretId: "XYZ-123") # Fixed missing 't'
player1.age = 23
echo player1.name, " is ", player1.age

# ref object
type Node = ref object
  data: int
  next: Node

var firstNode = Node(data: 10, next: nil)

# object variant
type
  ShapeKind = enum
    Circle
    Rectangle

  Shape = object
    case kind: ShapeKind
    of Circle:
      radius: float
    of Rectangle:
      width, height: float

let c = Shape(kind: Rectangle, width: 10.0, height: 5.0) # Fixed typo "Rectanglr"

# object methods and oop
type Car = object
  brand: string
  speed: int

proc accelerate(t: var Car, amount: int) =
  t.speed += amount

var myCar = Car(brand: "toyota", speed: 78)
myCar.accelerate(20)
echo myCar.speed # Fixed incorrect dot placement

# enum
type Direction = enum
  North
  East
  South
  West

let heading = Direction.North
echo heading
echo ord(heading)

type
  HTTPStatus = enum
    OK = 200
    NotFound = 404 # Fixed duplicate enum value assignment
    InternalError = 500

  CustomName = enum
    Default = "normal mode"
    Debug = "verbose diagnostic mode" # Fixed typo "Debud"

echo Default

# constructor patterns
# 1. new prefix
type DbConn = ref object
  host: string
  port: int
  conn: bool

proc newDbConn(host: string, port: int = 3030): DbConn =
  # Fixed default parameter syntax
  result = DbConn( # Fixed variable name (result instead of state)
    host: host, port: port, conn: false
  )
  echo "database allocation for: ", host

let db = newDbConn("127.0.0.1")

# 2. init prefix
type Config = object
  timeout: int
  debugMode: bool

proc initConfig(timeout: int, debug: bool): Config =
  if timeout <= 0:
    raise newException(ValueError, "timeout must be positive")
  result = Config(timeout: timeout, debugMode: debug)

var Configuration = initConfig(30, true)

# error handling
# 1. traditional
proc divNum() =
  echo "enter no to divide by 100: "
  let input = stdin.readLine() # Fixed std.readLine() -> stdin.readLine()

  try:
    let num = parseInt(input)
    let outcome = 100 div num
    echo "results: ", outcome
  except ValueError:
    echo "error: invalid integer"
  except DivByZeroDefect: # Fixed DivByZero -> DivByZeroDefect
    echo "error: cannot divide by zero"
  except CatchableError as e: # Capitalized CatchableError
    echo "unexpected error: ", e.msg
  finally:
    echo "div attempt done"

divNum()

# 2. raising exception
proc checkAge(age: int) =
  if age < 0:
    raise newException(ValueError, "age cant be negative")
  elif age < 18:
    echo "access denied"
  else:
    echo "access granted"

try:
  checkAge(-5)
except ValueError as e:
  echo "caught custom restriction: ", e.msg

# 3. option
proc safeDiv(a, b: int): Option[int] = # Capitalized Option
  if b == 0:
    return none(int)
  else:
    return some(a div b)

let ans = safeDiv(10, 0)
if ans.isSome: # Fixed typo "results.isSome" -> "ans.isSome"
  echo "success: ", ans.get()
else:
  echo "failed"
