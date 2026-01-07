import Foundation

func solve_1020() {
    let input = readLine()!.map { Int(String($0))! }
    let lineSegments = [6, 2, 5, 5, 4, 5, 6, 3, 7, 5]
    var dp = [[Int]](repeating: [Int](repeating: Int.max, count: input.count * 7 + 1), count: input.count + 1)

    // DP 생성
    for i in 0..<lineSegments.count {
        dp[1][lineSegments[i]] = min(dp[1][lineSegments[i]], i)
    }

    for i in 2..<dp.count {
        for j in 2..<8 {

            let start = (i - 1) * 2
            let end = (i - 1) * 7 + 1

            for k in start..<end {
                dp[i][j + k] = min(dp[i][j + k], 10^^(i - 1) * dp[1][j] + dp[i - 1][k])
            }
        }
    }

    var result = 10^^input.count

    // 첫번째 자리만으로 가능한 경우가 있는지 탐색
    for i in 0..<10 {
        let unit = input[input.count - 1]
        if lineSegments[unit] == lineSegments[i], unit != i {
            if i > unit {
                result = min(result, i - unit)
            } else {
                result = min(result, 10^^input.count + i - unit)
            }
        }
    }

    var count = lineSegments[input[input.count - 1]]

    // 두번째 자리(10의자리)부터 끝까지 탐색
    if input.count >= 2 {
        for i in 2...input.count {
            let digit = Int(input.suffix(i).map { String($0) }.joined())!

            count += lineSegments[input[input.count - i]]

            for num in 0..<10 {
                if count - lineSegments[num] >= 0 {
                    let pows = 10^^(i - 1) * num
                    let target = dp[i - 1][count - lineSegments[num]]

                    if target != Int.max, digit != pows + target {
                        var val = pows + target - digit
                        if val <= 0 { val += 10^^input.count }
                        result = min(result, val)
                    }
                }
            }
        }
    }
    print(result)
}

/*
 https://www.acmicpc.net/problem/1020
 디지털_카운터.1020
 2025.3.14
 
 */
