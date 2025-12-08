import Algorithms

struct DisjointSetUnion {
  var parent: [Int]
  var size: [Int]

  init(count: Int) {
    parent = Array(0..<count)
    size = [Int](repeating: 1, count: count)
  }

  mutating func find(_ i: Int) -> Int {
    if parent[i] == i {
      return i
    }
    parent[i] = find(parent[i])
    return parent[i]
  }

  mutating func unite(_ a: Int, _ b: Int) {
    let rootA = find(a)
    let rootB = find(b)
    guard rootA != rootB else { return }  // Already in the same set

    if size[rootA] < size[rootB] {
      parent[rootA] = rootB
      size[rootB] += size[rootA]  // Update size of the larger set
      size[rootA] = 0
    } else {
      parent[rootB] = rootA
      size[rootA] += size[rootB]  // Update size of the larger set
      size[rootB] = 0
    }
  }
}
struct Box {
  let x: Int
  let y: Int
  let z: Int
}

func distanceSquared(_ a: Box, _ b: Box) -> Int {
  intPow(a.x - b.x, 2) + intPow(a.y - b.y, 2) + intPow(a.z - b.z, 2)
}
struct Day08: AdventDay {
  let boxes: [Box]
  var edges: [(Int, Int, Int)] = []
  // Splits input data into its component parts and convert from string.
  init(data: String) {
    boxes = data.split(separator: "\n").map {
      let values = $0.split(separator: ",", maxSplits: 3).map { Int($0)! }
      return Box(x: values[0], y: values[1], z: values[2])
    }
    let count = boxes.count
    (0..<count).combinations(ofCount: 2).forEach{
      let i=$0[0]
      let j=$0[1]
      edges.append((i, j, distanceSquared(boxes[i], boxes[j])))
    }
    edges.sort { $0.2 < $1.2 }
  }
  public var itterations = 1000
  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    let count = boxes.count
    var dsu = DisjointSetUnion(count: count)
    for i in 0..<itterations {
      dsu.unite(edges[i].0, edges[i].1)
    }
    print(dsu.size.sorted().reversed())
    return dsu.size.sorted().reversed()[0...2].reduce(1, *)
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    let count = boxes.count
    var dsu = DisjointSetUnion(count: count)
    var curEdge = (0,0,0)
    for edge in edges {
      dsu.unite(edge.0, edge.1)
      curEdge = edge
      if dsu.size.sorted().last == count {break}
    }
    print(dsu.size.sorted().reversed())
    return boxes[curEdge.0].x * boxes[curEdge.1].x
  }
}
