import Foundation

func solve_1102() {
    let n = Int(readLine()!)!
    let costs = (0..<n).map { _ in readLine()!.components(separatedBy: " ").map { Int($0)! } }
    let state = Int(readLine()!.map { $0 == "Y" ? "1" : "0" }.joined(), radix: 2)!
    let t = Int(readLine()!)!
    var dp = [Int](repeating: Int.max, count: 65537)
    dp[state] = 0
    var ans = Int.max

    if state.nonzeroBitCount == 0 && t > 0 {
        print(-1)
        return
    }

    func dfs(_ currentState: Int, _ cost: Int) {

        if currentState.nonzeroBitCount >= t {
            ans = min(ans, cost)
            return
        }

        for i in 0..<n {
            if currentState & (1 << (n - i - 1)) == 0 { continue }
            
            for j in 0..<n {
                if currentState & (1 << (n - j - 1)) > 0 || i == j { continue }
                
                let nextState = currentState | (1 << (n - j - 1))
                
                if dp[nextState] > cost + costs[i][j] {
                    dp[nextState] = cost + costs[i][j]
                    dfs(nextState, cost + costs[i][j])
                }
            }
        }
    }
    dfs(state, 0)
    print(ans)
}

/*
 https://www.acmicpc.net/problem/1102
 발전소.1102
 2025.3.10
 
 플래티넘 치곤 좀 쉬운 문제.
 
 발전소의 온오프를 비트마스크로 DP를 만들어서 DFS로 탐색한다.
 
 */

