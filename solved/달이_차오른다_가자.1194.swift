import Foundation

func solve_1194() {
    let io = FileIO()
    let n = io.readInt(), m = io.readInt()
    let maze = (0..<n).map { _ in io.readString().map { String($0) } }
    var start: (r: Int, c: Int, k: Int) = (r: -1, c: -1, k: 0)

    for i in 0..<n {
        for j in 0..<m {
            if maze[i][j] == "0" {
                start = (r: i, c: j, k: 0)
                break
            }
        }
        if start.r != -1 { break }
    }

    let dx: [Int] = [0, -1, 0, 1]
    let dy: [Int] = [1, 0, -1, 0]

    var q = [start]
    var dp = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: -1, count: 51), count: 51), count: 65)

    dp[0][start.r][start.c] = 0
    var ans = Int.max

    while !q.isEmpty {
        let loc = q.removeFirst()

        for i in 0..<4 {

            let nr = loc.r + dx[i], nc = loc.c + dy[i]

            if !(0..<n ~= nr) || !(0..<m ~= nc) { continue }
            if maze[nr][nc] == "#" { continue }
            if maze[nr][nc] == "1" {
                ans = min(ans, dp[loc.k][loc.r][loc.c] + 1)
                continue
            }

            if dp[loc.k][nr][nc] == -1 {
                if ["a", "b", "c", "d", "e", "f"].contains(maze[nr][nc]) {
                    let nextkeybit = loc.k | (1 << Int(Character(maze[nr][nc]).asciiValue! - 97))
                    dp[nextkeybit][nr][nc] = dp[loc.k][loc.r][loc.c] + 1
                    q.append((r: nr, c: nc, k: nextkeybit))
                } else if ["A", "B", "C", "D", "E", "F"].contains(maze[nr][nc]) {
                    let keybit = Int(Character(maze[nr][nc]).asciiValue! - 65)
                    if loc.k & (1 << keybit) != 0 {
                        dp[loc.k][nr][nc] = dp[loc.k][loc.r][loc.c] + 1
                        q.append((r: nr, c: nc, k: loc.k))
                    }
                } else {
                    dp[loc.k][nr][nc] = dp[loc.k][loc.r][loc.c] + 1
                    q.append((r: nr, c: nc, k: loc.k))
                }
            }
        }
    }
    print(ans == Int.max ? -1 : ans)
}

/*
 https://www.acmicpc.net/problem/1194
 달이_차오른다_가자.1194
 2025.3.9

 */

