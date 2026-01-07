import Foundation

func solve_1079() {
    let n = Int(readLine()!)!
    let crimeScores = readLine()!.components(separatedBy: " ").map { Int($0)! }
    let deltaCrimeScores = (0..<n).map { _ in readLine()!.components(separatedBy: " ").map { Int($0)! } }
    let mafia = Int(readLine()!)!
    var ans = 0

    func dfs(_ css: [Int], _ nights: Int, _ survived: Int) -> Bool {
        if survived == 1 {
            ans = n / 2
            return true
        }

        if survived % 2 == 0 {
            for i in 0..<css.count {
                if css[i] == -1000 || i == mafia { continue }
                let temp = css.enumerated().map { $1 == -1000 || $0 == i ? -1000: $1 + deltaCrimeScores[i][$0] }
                if dfs(temp, nights + 1, survived - 1) {
                    return true
                }
            }
        } else {
            let target = css.max()!
            let targetIndex = css.firstIndex(where: { $0 == target })!
            if mafia == targetIndex {
                ans = max(ans, nights)
            } else {
                var temp = css
                temp[targetIndex] = -1000
                if dfs(temp, nights, survived - 1) {
                    return true
                }
            }
        }
        return false
    }

    let _ = dfs(crimeScores, 0, n)
    print(ans)
}

/*
 https://www.acmicpc.net/problem/1079
 마피아.1079
 2025.3.7
 
 처음엔 나의 유죄점수는 낮아지고 나를 제외한 다른 사람들은 가능한 높아지게 하는쪽으로 그리디+DP 문제인가 했는데 완전탐색 이었다.
 
 게임에 참여하는 최대인원수는 16명.
 
 완탐시 15 * 13 * 11 * 9 * 7 * 5 * 3 = 2027025 이다.(낮에는 내가 죽을 사람을 선택하지 않으므로 16!은 아니다.)
 
 이렇게 구현했는데 시간초과가 나서 살아남은 사람이 은진이 한명인경우 다른 모든 경우를 탐색해도 이거보다 많은 밤을 버틸수없기에 바로 종료해버리는 코드를 넣고 통과.
 
 */

