import Foundation

func solve_1006() {
    let io = FileIO()
    let tc = io.readInt()
    var ans = ""

    for _ in 0..<tc {
        let n = io.readInt(), w = io.readInt()
        let e = (0..<2).map { _ in (0..<n).map { _ in io.readInt() } }
        var dp = [[Int]](repeating: [Int](repeating: 0, count: 10001), count: 3)
        var sol = 20001

        dp[1][0] = 1
        dp[2][0] = 1

        func solve(_ s: Int) {
            for i in s..<n {
                dp[0][i + 1] = min(dp[1][i] + 1, dp[2][i] + 1)
                if e[0][i] + e[1][i] <= w {
                    dp[0][i + 1] = min(dp[0][i + 1], dp[0][i] + 1)
                }

                if i > 0 && e[0][i - 1] + e[0][i] <= w && e[1][i - 1] + e[1][i] <= w {
                    dp[0][i + 1] = min(dp[0][i + 1], dp[0][i - 1] + 2)
                }

                if i < n - 1 {
                    dp[1][i + 1] = dp[0][i + 1] + 1
                    if e[0][i] + e[0][i + 1] <= w {
                        dp[1][i + 1] = min(dp[1][i + 1], dp[2][i] + 1)
                    }
                    dp[2][i + 1] = dp[0][i + 1] + 1

                    if e[1][i] + e[1][i + 1] <= w {
                        dp[2][i + 1] = min(dp[2][i + 1], dp[1][i] + 1)
                    }
                }
            }
        }

        solve(0)
        sol = min(sol, dp[0][n])

        if n > 1 && e[0][0] + e[0][n - 1] <= w {
            dp[0][1] = 1
            dp[1][1] = 2
            dp[2][1] = e[1][0] + e[1][1] <= w ? 1 : 2
            solve(1)
            sol = min(sol, dp[2][n - 1] + 1)
        }

        if n > 1 && e[1][0] + e[1][n - 1] <= w {
            dp[0][1] = 1
            dp[1][1] = e[0][0] + e[0][1] <= w ? 1 : 2
            dp[2][1] = 2
            solve(1)
            sol = min(sol, dp[1][n - 1] + 1)
        }

        if n > 1 && e[0][0] + e[0][n - 1] <= w && e[1][0] + e[1][n - 1] <= w {
            dp[0][1] = 0
            dp[1][1] = 1
            dp[2][1] = 1
            solve(1)
            sol = min(sol, dp[0][n - 1] + 2)
        }
        ans += "\(sol)\n"
    }
    print(ans)
}

/*
 https://www.acmicpc.net/problem/1006
 습격자_초라기.1006
 2025.3.12
 https://casterian.net/ps/boj1006/
 */

