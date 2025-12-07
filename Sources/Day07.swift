import Algorithms

enum Node {
  case space
  case splitter
  case source
}

struct Day07: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Node]] {
    data.split(separator: "\n").map {
      $0.map {
        switch $0 {
        case "S": .source
        case ".": .space
        case "^": .splitter
        default: .space
        }
      }
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var splitCount = 0
    var beams = [Bool](repeating: false, count: entities.first!.count)
    for row in entities {
      for (index, node) in row.enumerated() {
        switch node {
        case .space: break
        case .source: beams[index] = true
        case .splitter:
          if beams[index] {
            splitCount += 1
            beams[index - 1] = true
            beams[index] = false
            beams[index + 1] = true  //will crash with splitters in first or last column.
          }
        }
      }

    }
    return splitCount
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var timelineState = [Int](repeating: 0, count: entities.first!.count)  // slides down the data keeping track of the timelines that get to each node
    for row in entities {
      for (index, node) in row.enumerated() {
        switch node {
        case .source: timelineState[index] = 1
        case .space: break
        case .splitter:
          timelineState[index - 1] += timelineState[index]
          timelineState[index + 1] += timelineState[index]
          timelineState[index] = 0
        }
      }
    }
    return timelineState.reduce(0, +)
  }
}
