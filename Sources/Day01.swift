import Algorithms

enum Rotation {
  case l(Int)
  case r(Int)
}

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [Rotation] {
    data.split(separator: "\n").map { (s: Substring) in
      let clicks = Int(s.dropFirst()) ?? 0
      return switch s.first {
        case "L": .l(clicks)
        case "R": .r(clicks)
        default: fatalError("invalid input")
      }
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any  {
    var pos = 50
    var count = 0
    for x in entities {
      switch x {
        case .l(let y): pos -= y
        case .r(let y): pos += y
      }
      if pos % 100 == 0 {
        count+=1
      }
    }
    return count
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var pos = 50
    var count = 0
    for x in entities {
      print("rd rot \(x)")
      let dif = switch x {
        case .l(let clicks): -clicks
        case .r(let clicks): clicks
      }
      print("rd dif \(dif)")
      let fullRotations = abs(dif/100)
      print("rd full = \(fullRotations)")
      count += fullRotations
      print("rd count \(count)")
      let oldpos = pos
      pos += dif%100
      if ((pos >= 100) || (pos <= 0))
      && (oldpos != 0) { // passed or landed on zero
        count += 1
        print("rd count \(count)")
      }
      pos = (pos + 100) % 100
      print("rd new pos \(pos)")
    }
    return count
  }
}
