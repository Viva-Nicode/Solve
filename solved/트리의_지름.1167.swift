import Foundation

func solve_1167() {

    let vertexCount = Int(readLine()!)!
    var visited: Set<Int> = [0]

    var adjacencyList = [[(v: Int, c: Int)]](repeating: [], count: vertexCount)
    for _ in 0..<vertexCount {
        var edges = readLine()!.components(separatedBy: " ")
        let vertexNumber = Int(edges.removeFirst())!

        for i in stride(from: 0, through: edges.count, by: 2) {
            if i + 1 < edges.count - 1 {
                adjacencyList[vertexNumber - 1].append((v: Int(edges[i])! - 1, c: Int(edges[i + 1])!))
            }
        }
    }

    func findLooongVertex(_ state: (v: Int, c: Int)) -> (v: Int, c: Int) {
        var rrr = state
        for ddd in adjacencyList[state.v] {
            if !visited.contains(ddd.v) {
                visited.insert(ddd.v)
                let asdf = findLooongVertex((v: ddd.v, c: state.c + ddd.c))
                rrr = asdf.c > rrr.c ? asdf : rrr
            }
        }
        return rrr
    }

    let leaf = findLooongVertex((0, 0))
    visited = [leaf.v]

    let result = findLooongVertex((v: leaf.v, c: 0))
    print(result.c)
}

/*
 https://www.acmicpc.net/problem/1167
 2025.2.13
 
 어느 임의의 정점에서 다른 모든 정점까지의 거리중 가장 먼거리의 정점을 구한다.
 구해진 정점에서 다른 모든 정점까지의 거리중 가장 먼거리의 정점 까지의 거리가 정답이다.
 
 */

