import Algorithms

struct Day05: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var ranges: [Range<Int>]
  var ids: [Int]

  init(data: String) {
    let entities = data.split(separator: "\n\n")
    assert(entities.count == 2)
    ranges = entities[0].split(separator: "\n").map{
      $0.split(separator: "-", maxSplits: 2)  .map{
        Int($0)!
      }.adjacentPairs().first.map{(a, b) in
      a..<(b+1)
      }!
    } //<evil laugh>

    ids = entities[1].split(separator: "\n").map{
      Int($0)!
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    let rs = RangeSet(ranges)
    return ids.map{
      rs.contains($0)
    }.count{$0 == true}
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    RangeSet(ranges).ranges.reduce(0){
      $0 + ($1.count)
    }
  }
}
