import Algorithms

func intPow(_ x: Int, _ y: Int) -> Int {
  if y == 0 { return 1 }
  return x * intPow(x, y - 1)
}

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [ClosedRange<Int>] {
    data.split(separator: ",").map {
      let pair = $0.split(separator: "-")
      return Int(pair[0])!...Int(pair[1])!
    }
  }

  func digits(_ x: Int) -> Int {
    var digits = 0
    var num = x
    while num > 0 {
      digits += 1
      num /= 10
    }
    return digits
  }

  func invalid(_ x: Int) -> Bool {
    let z = intPow(10, (digits(x) / 2))
    return x / z == x % z
  }
  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var total = 0
    for range in entities {
      total += range.filter(invalid).reduce(0, +)
    }
    return total
  }

  func invalid2(_ n: Int) -> Bool {
    let l = digits(n)
    for divisor in 1..<l {
      if l % divisor != 0 { continue }
      let r = (intPow(10, l) - 1) / (intPow(10, divisor) - 1)
      if n % r == 0 {
        let b = n / r
        if digits(b) == divisor {
          return true
        }
      }
    }
    return false
  }
  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
        var total = 0
    for range in entities {
      total += range.filter(invalid2).reduce(0, +)
    }
    return total
  }
}
