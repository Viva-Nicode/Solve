import Foundation

func solve_1033() {
    let N = Int(readLine()!)!

    var graph = [[(Int, Int, Int)]](repeating: [], count: N)
    var lcm = 1

    func gcd(_ a: Int, _ b: Int) -> Int {
        b == 0 ? a : gcd(b, a % b)
    }

    // 그래프 입력 받기
    for _ in 0..<N - 1 {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let a = input[0], b = input[1], p = input[2], q = input[3]
        graph[a].append((b, p, q))
        graph[b].append((a, q, p))
        lcm *= (p * q / gcd(p, q))
    }

    var visited = [Bool](repeating: true, count: N)
    var li = [Int](repeating: 0, count: N)
    li[0] = lcm

    func DFS(_ v: Int) {
        visited[v] = false
        for edge in graph[v] {
            let next = edge.0
            if visited[next] {
                li[next] = li[v] * edge.2 / edge.1
                DFS(next)
            }
        }
    }

    DFS(0)

    var mgcd = li[0]
    for i in 1..<N {
        mgcd = gcd(mgcd, li[i])
    }

    for i in 0..<N {
        print(li[i] / mgcd, terminator: " ")
    }
}

/*
 https://www.acmicpc.net/problem/1033
 칵테일.1033
 2025.3.28
 
 */

