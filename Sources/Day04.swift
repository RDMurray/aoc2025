import Algorithms

public enum CrossCorrelationError: Error {
  case emptyInput
  case emptyKernel
  case nonRectangularInput
  case nonRectangularKernel
}

public func crossCorrelate2D<T: BinaryInteger>(
  input: [[T]],
  kernel: [[T]]
) throws -> [[T]] {

  guard !input.isEmpty, !input[0].isEmpty else { throw CrossCorrelationError.emptyInput }
  guard !kernel.isEmpty, !kernel[0].isEmpty else { throw CrossCorrelationError.emptyKernel }

  let inputRows = input.count
  let inputCols = input[0].count
  let kernelRows = kernel.count
  let kernelCols = kernel[0].count

  guard input.allSatisfy({ $0.count == inputCols }) else {
    throw CrossCorrelationError.nonRectangularInput
  }
  guard kernel.allSatisfy({ $0.count == kernelCols }) else {
    throw CrossCorrelationError.nonRectangularKernel
  }

  // Zero padding equal to floor(kernel_size / 2)
  let padR = kernelRows / 2
  let padC = kernelCols / 2

  // Output has same size as input
  var output = Array(
    repeating: Array(repeating: T.zero, count: inputCols),
    count: inputRows
  )

  // Slide kernel over padded input
  for r in 0..<inputRows {
    for c in 0..<inputCols {
      var acc: T = 0

      for kr in 0..<kernelRows {
        for kc in 0..<kernelCols {
          let ir = r + kr - padR  // input row after padding
          let ic = c + kc - padC  // input col after padding

          // Only accumulate if inside original input
          if ir >= 0, ir < inputRows, ic >= 0, ic < inputCols {
            acc += input[ir][ic] * kernel[kr][kc]
          }
        }
      }

      output[r][c] = acc
    }
  }

  return output
}

struct Day04: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Int]] {
    data.split(separator: "\n").map {
      $0.map {
        switch $0 {
        case "@": 1
        default: 0
        }
      }
    }
  }

  // kernel such that each roll counts as one, and the center roll counts as -4, thus an output from cross correlation of less than zero means access is possible
  let kernel = [
    [1, 1, 1],
    [1, -4, 1],
    [1, 1, 1],
  ]

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    do {
      let corr = try crossCorrelate2D(input: entities, kernel: kernel)
      return corr.joined().reduce(0) {
        $0 + (($1 < 0) ? 1 : 0)
      }
    } catch {
      print(error)
      return 0
    }
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var totalRemoved = 0
    var curAccessibleCount = 0
    var state = entities
    do {
      repeat {
        let corr = try crossCorrelate2D(input: state, kernel: kernel)
        curAccessibleCount = corr.joined().reduce(0) {
          $0 + (($1 < 0) ? 1 : 0)
        }
        state = zip(state, corr).map { stateRow, corrRow in
          zip(stateRow, corrRow).map { s, c in
            (c < 0) ? 0 : s
          }
        }
        totalRemoved += curAccessibleCount
        print(curAccessibleCount)
      } while curAccessibleCount > 0
    } catch {
      print(error)
      return 0
    }
    return totalRemoved
  }
}
