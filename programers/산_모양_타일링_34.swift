import Foundation

func solution_34(_ n: Int, _ tops: [Int]) -> Int {
    var withThirdWay = Array(repeating: 0, count: n + 1) // 3번 방법으로만 채울 수 있는 경우의 수
    var withoutThirdWay = Array(repeating: 0, count: n + 1) // 3번 방법을 제외하고 채울 수 있는 경우의 수 (1,2,4번 방법)

    withThirdWay[1] = 1
    withoutThirdWay[1] = tops[0] == 1 ? 3 : 2

    if n == 1 {
        return withThirdWay[1] + withoutThirdWay[1]
    }

    let mod = 10007

    for i in 2..<n + 1 {
        if tops[i - 1] == 1 { // 위에 삼각형이 붙은 경우
            withThirdWay[i] = withThirdWay[i - 1] + withoutThirdWay[i - 1]
            withoutThirdWay[i] = 2 * withThirdWay[i - 1] + 3 * withoutThirdWay[i - 1]
        } else { // 위에 삼각형이 붙지 않은 경우
            withThirdWay[i] = withThirdWay[i - 1] + withoutThirdWay[i - 1]
            withoutThirdWay[i] = withThirdWay[i - 1] + 2 * withoutThirdWay[i - 1]
        }

        withThirdWay[i] %= mod
        withoutThirdWay[i] %= mod
    }

    return (withThirdWay[n] + withoutThirdWay[n]) % 10007
}
