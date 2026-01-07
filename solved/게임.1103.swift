import Foundation

func solve_1103_pass() {
    let boardSize = readLine()!.components(separatedBy: " ").map { Int($0)! }
    let n = boardSize[0], m = boardSize[1]
    var board: [[String]] = []
    (0..<n).forEach { _ in board.append(readLine()!.map { String($0) }) }
    var dp = [[Int]](repeating: [Int](repeating: -1, count: m), count: n)
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: m), count: n)
    let directions = [(-1, 0), (1, 0), (0, 1), (0, -1)]

    func dfs(_ r: Int, _ c: Int) -> Int {
        if !(0..<n ~= r && 0..<m ~= c) || board[r][c] == "H" { return 0 }
        if visited[r][c] { return Int.max }
        if dp[r][c] != -1 { return dp[r][c] }

        visited[r][c] = true

        let move = Int(board[r][c])!

        for dir in directions {
            let result = dfs(r + dir.0 * move, c + dir.1 * move)

            if result == Int.max { return Int.max }
            dp[r][c] = max(dp[r][c], result + 1)
        }

        visited[r][c] = false
        return dp[r][c]
    }

    let answer = dfs(0, 0)
    print(answer == Int.max ? -1 : answer)
}

func solve_1103_timeout() {

    struct Location_1103: Hashable {
        var r: Int
        var c: Int
    }

    let boardSize = readLine()!.components(separatedBy: " ").map { Int($0)! }
    var board: [[String]] = []
    var dp = [[Int]](repeating: [Int](repeating: -1, count: boardSize[1]), count: boardSize[0])

    let directions = [
        (r: -1, c: 0),
        (r: 1, c: 0),
        (r: 0, c: 1),
        (r: 0, c: -1)]

    for _ in 0..<boardSize[0] {
        let row = readLine()!.map { String($0) }
        board.append(row)
    }

    func move_1103(_ visited: Set<Location_1103>, _ location: Location_1103, _ moveCount: Int) -> Int {

        var result = -1
        let moveableCount = Int(board[location.r][location.c])!

        dp[location.r][location.c] = max(dp[location.r][location.c], moveCount)
        var newVisited = visited
        newVisited.insert(location)

        for dir in directions {
            let next = Location_1103(r: location.r + dir.r * moveableCount, c: location.c + dir.c * moveableCount)

            if visited.contains(next) {
                return Int.max
            } else if !(0..<boardSize[0] ~= next.r && 0..<boardSize[1] ~= next.c) || board[next.r][next.c] == "H" {
                result = max(result, moveCount)
            } else {
                if moveCount + 1 < dp[next.r][next.c] {
                    continue
                } else {
                    result = max(result, move_1103(newVisited, next, moveCount + 1))
                    if result == Int.max {
                        return result
                    }
                }
            }
        }

        return result
    }

    let answer = move_1103([Location_1103(r: 0, c: 0)], Location_1103(r: 0, c: 0), 1)
    print(answer == Int.max ? -1 : answer)
}

/*
 https://www.acmicpc.net/problem/1103
 2025.2.14
 
 */

/*
 
5 4 -1 4 1 2
 
3 7
3942178
1234567
9123532

1 10
2H3HH4HHH5

4 4
3994
9999
9999
2924

4 6
123456
234567
345678
456789

1 1
9

3 7
2H9HH11
HHHHH11
9HHHH11
 */
