import Foundation

func solution_16(_ points: [[Int]], _ routes: [[Int]]) -> Int {
    var table: [[(x: Int, y: Int)]] = []

    for route in routes {
        var path: [(x: Int, y: Int)] = []

        for loc in 1..<route.count {
            var start = points[route[loc - 1] - 1]
            let end = points[route[loc] - 1]
            path.append((x: start[0], y: start[1]))

            while true {
                if start[0] != end[0] {
                    if start[0] < end[0] {
                        start[0] += 1
                    } else {
                        start[0] -= 1
                    }
                    if !(start[0] == end[0] && start[1] == end[1]) {
                        path.append((x: start[0], y: start[1]))
                    }
                } else if start[1] != end[1] {
                    if start[1] < end[1] {
                        start[1] += 1
                    } else {
                        start[1] -= 1
                    }
                    if !(start[0] == end[0] && start[1] == end[1]) {
                        path.append((x: start[0], y: start[1]))
                    }
                } else {
                    break
                }
            }
        }
        path.append((x: points[route[route.count - 1] - 1][0], y: points[route[route.count - 1] - 1][1]))
        table.append(path)
    }
    let tt = transposeTable(table)
    let s = countDuplicateCoordinates(in: tt)

    return s.reduce(0) { (a: Int, b: Int) -> Int in
        return a + b
    }
}

func countDuplicateCoordinates(in table: [[(x: Int, y: Int)]]) -> [Int] {
    var result: [Int] = []

    for row in table {
        // 좌표 집계
        var frequency: [String: Int] = [:]
        for coord in row {
            if coord.x == -1 && coord.y == -1 { continue } // (-1, -1) 제외
            let key = "\(coord.x),\(coord.y)"
            frequency[key, default: 0] += 1
        }

        // 2번 이상 나타난 좌표 개수 계산
        let duplicates = frequency.values.filter { $0 >= 2 }.count
        result.append(duplicates)
    }

    return result
}

func transposeTable(_ table: [[(x: Int, y: Int)]], fillValue: (x: Int, y: Int) = (x: -1, y: -1)) -> [[(x: Int, y: Int)]] {
    let maxLength = table.map { $0.count }.max() ?? 0

    // 결과 배열 초기화
    var transposed: [[(x: Int, y: Int)]] = Array(repeating: [], count: maxLength)

    for row in table {
        for (colIndex, value) in row.enumerated() {
            transposed[colIndex].append(value) // 컬럼을 로우로 변경
        }

        // 나머지 빈 자리는 fillValue로 채움
        for colIndex in row.count..<maxLength {
            transposed[colIndex].append(fillValue)
        }
    }

    return transposed
}
