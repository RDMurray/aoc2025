import Algorithms

struct Day03: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Int]] {
    data.split(separator: "\n").map {
      $0.map{Int(String($0))!}
    }
  }

  func maxJolts <T: RandomAccessCollection> (_ bank: T) -> Int
  where T.Element == Int, T.Index == Int{
    let maxFirst = bank.dropLast().max()
    let firstPosCandidates = bank.dropLast().indices(where: {$0 == maxFirst})
    var candidates: [Int] = []
    for range in firstPosCandidates.ranges {
      for i in range {
        let m = bank[(i+1)...].max()!
        candidates.append(bank[i]*10+m)
      }
    }
    return candidates.max()!
  }
  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    entities.map{
      maxJolts($0)
    }.reduce(0, +)
  }
// attempted to use array slices for the recursion but it fails due to the reliance on integer indices
  func maxJolts <T: RandomAccessCollection> (of bank: T, size: Int) -> Int
  where T.Element == Int, T.Index == Int {
    if size == 2 {
      return maxJolts(bank)
    }
    let maxFirst = bank.dropLast(size-1).max()
    let firstPosCandidates = bank.dropLast(size-1).indices(where: {$0 == maxFirst})
    var candidates: [Int] = []
    for range in firstPosCandidates.ranges {
      for i in range {
        candidates.append(intPow(10, size-1) * bank[i]
          + maxJolts(of: Array(bank[(i+1)...]), size: size-1))
      }
    }
    return candidates.max()!
  }


  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    entities.map{
      maxJolts(of: $0, size: 12)
    }.reduce(0, +)
  }
}
