import Foundation

func solve_2252() {
    let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
    var answer = ""
    var adjacencyList = [[Int]](repeating: [], count: input[0])
    var inDegree = [Int](repeating: 0, count: input[0])

    for _ in 0..<input[1] {
        let comp = readLine()!.components(separatedBy: " ").map { Int($0)! }
        adjacencyList[comp[0] - 1].append(comp[1] - 1)
        inDegree[comp[1] - 1] += 1
    }

    var queue = [Int]()
    var idx = 0

    for i in 0..<input[0] {
        if inDegree[i] == 0 {
            queue.append(i)
        }
    }

    while queue.count > idx {
        let popped = queue[idx]
        answer += "\(popped + 1) "
        idx += 1

        for vertex in adjacencyList[popped] {
            inDegree[vertex] -= 1
            if inDegree[vertex] == 0 {
                queue.append(vertex)
            }
        }
    }

    print(answer)
}

/*
 https://www.acmicpc.net/problem/2252
 2025.2.15
 위상 정렬 문제
 
 
 */
