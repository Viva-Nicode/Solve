import Foundation

// 결국 못품 하하 어렵다. 힘들다. 슬프다.
func getCost(_ board: [[Int]], _ start: [Int], _ des: [Int]) -> Int {

    var visited: [[Int]] = []
    var next: [[Int]] = [start]
    let dx: [Int] = [0, -1, 0, 1]
    let dy: [Int] = [1, 0, -1, 0]
    // 하 좌 상 우

    while !next.isEmpty {
        let node = next.removeFirst()
        visited.append(node[0...1].map { $0 })

        // 도착했으면 return
        if node[0] == des[0] && node[1] == des[1] {
            print("\(start) -> \(des) : \(node[2])")
            return node[2]
        }

        for i in 0..<4 {

            var newNode = node

            newNode[0] += dx[i]
            newNode[1] += dy[i]
            newNode[2] += 1

            if 0..<4 ~= newNode[0] && 0..<4 ~= newNode[1] && !visited.contains(newNode[0...1].map { $0 }) {
                next.append(newNode)
            }

            var fullNode = node
            fullNode[2] += 1

            while true {
                if 0..<4 ~= fullNode[0] + dx[i] && 0..<4 ~= fullNode[1] + dy[i] {
                    fullNode[0] += dx[i]
                    fullNode[1] += dy[i]

                    if i == 0 {
                        if board[fullNode[0]][fullNode[1]] == 1 || fullNode[1] == 3 {
                            break
                        }
                    } else if i == 1 {
                        if board[fullNode[0]][fullNode[1]] == 1 || fullNode[0] == 0 {
                            break
                        }
                    } else if i == 2 {
                        if board[fullNode[0]][fullNode[1]] == 1 || fullNode[1] == 0 {
                            break
                        }
                    } else if i == 3 {
                        if board[fullNode[0]][fullNode[1]] == 1 || fullNode[0] == 3 {
                            break
                        }
                    }
                } else {
                    break
                }
            }

            if !(fullNode[0] == newNode[0] && fullNode[1] == newNode[1]) && !(fullNode[0] == node[0] && fullNode[1] == node[1]) &&
                !visited.contains(fullNode[0...1].map { $0 }) {
                next.append(fullNode)
            }
        }
    }
    return 0
}

func permutations<T>(_ array: [T]) -> [[T]] {
    if array.count == 1 { return [array] }
    var result: [[T]] = []
    for (index, element) in array.enumerated() {
        var remaining = array
        remaining.remove(at: index)
        result += permutations(remaining).map { [element] + $0 }
    }
    return result
}

func findCoordinates(of target: Int, in array: [[Int]]) -> [(x: Int, y: Int)] {
    var coordinates: [(x: Int, y: Int)] = []

    for (x, row) in array.enumerated() {
        for (y, element) in row.enumerated() {
            if element == target {
                coordinates.append((x: x, y: y))
            }
        }
    }
    return coordinates
}

func dfs_2(_ board: [[Int]], seq: [Int], cs: (x: Int, y: Int, cost: Int)) -> Int {

    if seq.isEmpty {
        return cs.cost
    }

    let targets = findCoordinates(of: seq[0], in: board)
    let newBoard = board.map { $0.map { $0 == seq[0] ? 0: $0 } }

    // 0 -> 1
    var cost = getCost(board.map { $0.map { $0 != 0 ? 1: $0 } }, [cs.x, cs.y, 0], [targets[0].x, targets[0].y])
    cost += getCost(board.map { $0.map { $0 != 0 ? 1: $0 } }, [targets[0].x, targets[0].y, 0], [targets[1].x, targets[1].y])
    let c1 = dfs_2(newBoard, seq: Array(seq.dropFirst()), cs: (x: targets[1].x, y: targets[1].y, cost: cs.cost + cost))

    // 1 -> 0
    var cost2 = getCost(board.map { $0.map { $0 != 0 ? 1: $0 } }, [cs.x, cs.y, 0], [targets[1].x, targets[1].y])
    cost2 += getCost(board.map { $0.map { $0 != 0 ? 1: $0 } }, [targets[1].x, targets[1].y, 0], [targets[0].x, targets[0].y])
    let c2 = dfs_2(newBoard, seq: Array(seq.dropFirst()), cs: (x: targets[0].x, y: targets[0].y, cost: cs.cost + cost2))

    return min(c1, c2)
}

func solution_17(_ board: [[Int]], _ r: Int, _ c: Int) -> Int {

    var result = Int.max
    let cardsPermutations = permutations(Array(Set(board.flatMap { $0 }.filter { $0 != 0 })))

    for permutation in cardsPermutations {
        let cc = dfs_2(board, seq: permutation, cs: (x: c, y: r, cost: 0))
        result = min(cc, result)
    }

    return result + cardsPermutations[0].count * 2
}
