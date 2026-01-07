import Foundation

let alp = 1
let cop = 1
let problems: [[Int]] = [[0, 2, 1, 1, 100]]
//1

func solution_18(_ alp: Int, _ cop: Int, _ problems: [[Int]]) -> Int {

    var maxPower: [Int] = [0, 0]
    for problem in problems { maxPower = [max(problem[0], maxPower[0]), max(problem[1], maxPower[1])] }

    var dp: [[Int]] = Array(repeating: Array(repeating: 10000, count: maxPower[0] + 1), count: maxPower[1] + 1)
    dp[alp][cop] = 0

    if alp >= maxPower[0] && cop >= maxPower[1] { return 0 }

    for ci in cop..<dp.count {
        for ai in alp..<dp[0].count {

            if ai + 1 <= dp[0].indices.last ?? 0 {
                dp[ci][ai + 1] = min(dp[ci][ai + 1], dp[ci][ai] + 1)
            }

            if ci + 1 <= dp.indices.last ?? 0 {
                dp[ci + 1][ai] = min(dp[ci + 1][ai], dp[ci][ai] + 1)
            }

            for problem in problems { // 문제를 돌면서
                if problem[0] <= ai && problem[1] <= ci { // 풀수 있으면 푼다.

                    let aidx = min(dp[0].indices.last ?? 0, ai + problem[2])
                    let cidx = min(dp.indices.last ?? 0, ci + problem[3])

                    dp[cidx][aidx] = min(dp[cidx][aidx], dp[ci][ai] + problem[4])
                }
            }
        }
    }
    print(dp)
    return dp[maxPower[1]][maxPower[0]]
}

func gg(_ alp: Int, _ cop: Int, _ problems: [[Int]]) -> Int {
    let maxAlp = problems.map { $0[0] }.max()!
    let maxCop = problems.map { $0[1] }.max()!
    let alp = min(alp, maxAlp)
    let cop = min(cop, maxCop)
    let INF = 10000
    var dp = Array(repeating: Array(repeating: INF, count: maxCop + 1), count: maxAlp + 1)
    dp[alp][cop] = 0

    for a in alp..<maxAlp + 1 {
        for c in cop..<maxCop + 1 {
            var flag = false

            if a + 1 <= maxAlp {
                dp[a + 1][c] = min(dp[a + 1][c], dp[a][c] + 1)
                flag = true
            }
            if c + 1 <= maxCop {
                dp[a][c + 1] = min(dp[a][c + 1], dp[a][c] + 1)
                flag = true
            }

            if flag {
                for problem in problems {
                    let (alp_req, cop_req, alp_rwd, cop_rwd, cost) = (problem[0], problem[1], problem[2], problem[3], problem[4])

                    if a >= alp_req && c >= cop_req {
                        let totalAlp = min(maxAlp, a + alp_rwd)
                        let totalCop = min(maxCop, c + cop_rwd)
                        dp[totalAlp][totalCop] = min(dp[totalAlp][totalCop], dp[a][c] + cost)
                    }
                }
            }
        }
    }
    return dp[maxAlp][maxCop]
}
