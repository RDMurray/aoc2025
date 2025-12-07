import Algorithms

struct Day06: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.

  let problems: [([Int], Substring)]
  let data: String

  init(data: String) {
    self.data = data
    // this is only useful for part 1
    let input = data.split(separator: "\n").map {
      $0.split(separator: " ", omittingEmptySubsequences: true)
    }
    let firstRow = input.first!
    let transposed = (0..<firstRow.count).map { index in
      input.map { $0[index] }
    }
    problems = transposed.map { problem in
      (
        problem.dropLast().map { Int($0)! },
        problem.last!
      )
    }

  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    problems.map { (nums, op) in
      if op == "+" {
        return nums.reduce(0, +)
      } else {
        return nums.reduce(1, *)
      }
    }.reduce(0, +)
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    let lines = data.split(separator: "\n")
    let nums = lines.dropLast().map{$0.map(Character.init)}
    var ops = lines.last!.split(separator: " ", omittingEmptySubsequences: true)
    let width = nums.first!.count
    let rotated = (0..<width).map { index in
      let i = width - 1 - index  // right to left
      return nums.map { $0[i] }
    }.map { String($0) }
    ops.reverse()
    var problems: [([Int], Substring)] = [([], ops[0])]
    var curprob = 0
    for i in 0..<rotated.count {
      guard let num = Int(rotated[i].trimmingCharacters(in: .whitespaces)) else {
        curprob += 1
        problems.append(([], ops[curprob]))
        continue
      }
      problems[curprob].0.append(num)
    }
    return problems.map { (ns, op) in
      if op == "+" {
        return ns.reduce(0, +)
      } else {
        return ns.reduce(1, *)
      }

    }.reduce(0, +)
  }
}
