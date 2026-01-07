import Foundation

func solve_1023() {
    let io = FileIO()
    let n = io.readInt(), k = io.readInt()
    var dp = [[Int]](repeating: [Int](repeating: 0, count: 51), count: 51)
    var ans = ""

    dp[0][0] = 0
    dp[1][0] = 2
    dp[1][1] = 1

    for i in 2...50 {
        if i % 2 == 1 {
            dp[i][0] = dp[i - 2][0] * 4
        } else {
            dp[i][i] = 1
            for j in stride(from: i - 1, through: 1, by: -1) {
                dp[i][j] = dp[i][j + 1] + dp[i - 2][j - 1]
            }
            dp[i][0] = dp[i - 1][0] + dp[i][1]
        }
    }

    if k >= dp[n][0] {
        print(-1)
        return
    }

    if n % 2 == 1 {
        var bin = String(k, radix: 2)
        bin = String(repeating: "0", count: n - bin.count) + bin
        print(bin.map { $0 == "0" ? "(" : ")" }.joined())
        return
    }

    func printOdd(_ nn: Int, _ kk: Int) {
        var N = 1 << (nn - 1)
        while N > 0 {
            if kk & N == 0 ? false : true {
                ans += ")"
            } else {
                ans += "("
            }
            N >>= 1
        }
    }

    func printEven(_ N: Int, _ M: Int, _ K: Int) {
        if M == 0 {
            if K >= dp[N][1] {
                ans += ")"
                printOdd(N - 1, K - dp[N][1])
            } else {
                ans += "("
                printEven(N, 1, K)
            }
            return
        }

        if N == M { return }

        if K >= dp[N][M + 1] {
            ans += ")"
            printEven(N - 2, M - 1, K - dp[N][M + 1])
        } else {
            ans += "("
            printEven(N, M + 1, K)
        }
    }

    printEven(n, 0, k)
    print(ans)
}

/*
 https://www.acmicpc.net/problem/1023
 괄호_문자열.1023
 2025.3.17
 
 */

