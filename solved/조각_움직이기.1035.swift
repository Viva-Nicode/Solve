import Foundation

func solve_1035() {
    
    struct Point: Hashable {
        var c: Int
        var r: Int
    }

    func manhattan(_ a: Point, _ b: Point) -> Int {
        abs(a.c - b.c) + abs(a.r - b.r)
    }

    func minMoveDistance(a: [Point], b: [Point]) -> Int {
        let n = a.count
        var used = Array(repeating: false, count: n)
        var answer = Int.max

        func dfs(_ idx: Int, _ cost: Int) {
            if cost >= answer { return }
            if idx == n {
                answer = min(answer, cost)
                return
            }

            for i in 0..<n {
                if !used[i] {
                    used[i] = true
                    dfs(idx + 1, cost + manhattan(a[idx], b[i]))
                    used[i] = false
                }
            }
        }

        dfs(0, 0)
        return answer
    }

    func isValid(points: [Point]) -> Bool {

        let pointSet = Set(points)
        guard pointSet.count == points.count else { return false }

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        var visited = Set<Point>()

        func dfs(_ point: Point) {
            visited.insert(point)

            for (dc, dr) in directions {
                let next = Point(c: point.c + dc, r: point.r + dr)
                if pointSet.contains(next), !visited.contains(next) {
                    dfs(next)
                }
            }
        }
        dfs(points[0])

        return visited.count == points.count
    }

    let fio = FileIO()

    var segCount = 0
    var segPoints: [Point] = []
    var answer = 13

    for i in 0..<5 {
        let line = fio.readString().map { String($0) }
        let dd = line.enumerated().filter { $1 == "*" }.map { i, v in i }
        segCount += dd.count
        for d in dd {
            segPoints.append(.init(c: i, r: d))
        }
    }

    dfs(p: [])

    func dfs(p: [Point]) {
        if p.count < segCount {
            for c in 0...4 {
                for r in 0...4 {

                    var n = p
                    n.append(.init(c: c, r: r))

                    if isValid(points: n) {
                        dfs(p: n)
                    }

                }
            }
        } else {
            answer = min(answer, minMoveDistance(a: segPoints, b: p))
        }
    }

    print(answer)
}

/*
 https://www.acmicpc.net/problem/1035
 조각_움직이기.1035
 2026.1.5
 
 보드의 크기가와 조각의 수가 작다. -> 브루트 포스
 
 따라서 보드내에서 조각이 위치할 수있는 모든 경우의 수를 탐색하되, 조각이 겹쳐있는 경우와, 조각이 상하좌우로 연결되어 있지 않은 경우는 가지치기.
 
 탐색하면서 최솟값을 저장하고 출력하면 된다.
 */
