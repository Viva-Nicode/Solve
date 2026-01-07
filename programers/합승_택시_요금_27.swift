import Foundation

struct X_Node: Comparable {

    var index: Int
    var value: Int

    static func < (lhs: X_Node, rhs: X_Node) -> Bool {
        lhs.value < rhs.value
    }
}

struct X_Heap<T:Comparable> {
    // 힙은 (현재인덱스 *2) 와 (현재인덱스 * 2 + 1)로 자신의 왼쪽 자식, 오른쪽 자식 노드를 찾는다.
    // 때문에 루트노드의 인덱스가 0이면 성립되지 않으므로 0번째 인덱스에 더미값을 넣는다.
    // 따라서 최상위 루트노드의 인덱스는 1이 된다.
    var heap: [T] = []

    init(_ dummy: T) {
        heap.append(dummy) // 더미 값 추가 (비교 시 사용되지 않음)
    }

    mutating func append(_ elem: T) {
        // 배열의 맨 끝 즉 리프노드에 새로운 값을 넣는다.
        heap.append(elem)
        var idx = heap.count - 1
        // 새롭게 넣어진 값이 부모노드보다 작다면 부모와 값을 바꾼다.
        // 새롭게 넣어진 값의 인덱스가 홀수(오른쪽자식)이든 짝수(왼쪽 자식)이든 2로 나누면 부모를 찾아갈 수 있다.
        while idx > 1 && heap[idx] < heap[idx / 2] {
            heap.swapAt(idx, idx / 2)
            idx /= 2
        }
    }

    mutating func getElem() -> T {

        // 루트 노드(최소값)을 저장한다.
        let value = heap[1]

        // 루트노드값과 최하단 리프노드 값을 바꾸고 마지막 값(루트노드였던 값)을 삭제한다.
        heap.swapAt(1, heap.count - 1)
        heap.removeLast()

        var idx = 1

        while true {
            let leftChild: T? = idx * 2 < heap.count ? heap[idx * 2] : nil
            let rightChild: T? = idx * 2 + 1 < heap.count ? heap[idx * 2 + 1] : nil

            if leftChild == nil {
                // 자식이 존재하지않으면 그대로 리턴
                return value
            } else {
                if rightChild == nil {
                    // 왼쪽 자식만 존재하고 자식이 더 작으면 값 스왑하고 인덱스를 자식으로 바꿔준다.
                    if heap[idx] > leftChild! {
                        heap.swapAt(idx, idx * 2)
                        idx = idx * 2
                    } else {
                        // 왼쪽 자식만 존재하고 자식이 더 크면 그대로 리턴
                        return value
                    }
                } else {
                    // 왼쪽 오른쪽 자식이 전부 존재하면 두 자식중 더 작은 값을 선택한다.
                    let cidx = leftChild! > rightChild! ? idx * 2 + 1: idx * 2

                    // 선택된 자식이 자신보다 작으면 값 스왑하고 인덱스를 자식으로 바꿔준다.
                    if heap[cidx] < heap[idx] {
                        heap.swapAt(idx, cidx)
                        idx = cidx
                    } else {
                        // 두 자식이 전부 자신보다 크면 그대로 리턴
                        return value
                    }
                }
            }
        }
    }

    var isEmpty: Bool {
        heap.count <= 1
    }
}

func dijkstra(_ src: Int, _ table: inout [[Int]]) {

    var visited = Array(repeating: false, count: table[0].count)
    var heap = X_Heap(X_Node(index: 0, value: -1))
    // 출발 정점을 방문처리 한다.
    visited[src] = true
    table[src].enumerated().forEach { heap.append(.init(index: $0, value: $1)) }

    while !heap.isEmpty {
        let node = heap.getElem()

        // 이미 방문한 정점이라면 스킵한다.
        if visited[node.index] { continue }

        for i in 0..<table[0].count {
            // src 정점에서 node.index 정점을 거친 후 i정점으로 가는 비용이
            // src 정점에서 바로 i정점으로 가는 비용보다 저렴하다면 최소비용을 더 져렴하게 갱신해준다.
            if table[src][i] > table[src][node.index] + table[node.index][i] {
                table[src][i] = table[src][node.index] + table[node.index][i]
                heap.append(.init(index: i, value: table[src][i]))
            }
        }

        visited[node.index] = true
    }
}

func solution_27(_ n: Int, _ s: Int, _ a: Int, _ b: Int, _ fares: [[Int]]) -> Int {

    var result: Int = .max
    var costTable: [[Int]] = Array(repeating: Array(repeating: 20000001, count: n), count: n)

    for fare in fares {
        costTable[fare[0] - 1][fare[1] - 1] = fare[2]
        costTable[fare[1] - 1][fare[0] - 1] = fare[2]
    }

    (0..<n).forEach { costTable[$0][$0] = 0 }

    dijkstra(s - 1, &costTable)
    dijkstra(a - 1, &costTable)
    dijkstra(b - 1, &costTable)

    result = costTable[s - 1][a - 1] + costTable[s - 1][b - 1]

    for i in 0..<n {
        result = min(result, costTable[s - 1][i] + costTable[a - 1][i] + costTable[b - 1][i])
    }

    return result
}

/*
 https://school.programmers.co.kr/learn/courses/30/lessons/72413
 
 노드와 간선이 존재하고 최소 비용을 찾는 문제이므로 다익스트라 또는 플로이드 워셜로 풀수 있다.
 
 플로이드 워셜은 모든 정점에서 다른 모든 정점까지의 최소비용을 구하는 n^3의 알고리즘이지만
 
 문제에 의하면 s정점, a정점, b정점에서부터 모든 정점까지의 최소비용만 구하면 되므로 다익스트라가 적합하다고 생각했다.
 
 다익스트라 알고리즘의 시간복잡도를 줄이기위해 최소 힙을 구현했다.
 
 힙은 완전 이진트리로 표현될 수 있는데 이는 마지막 레벨을 제외하고 모든 레벨이 완전히 채워져 있으며,
 
 마지막 레벨의 모든 노드는 가능한 한 가장 왼쪽에 있고, 마지막 레벨 h에서 1부터 2h-1 개의 노드를 가질 수 있는 트리를 말한다.
 
 처음부터 합승하지 않고 따로 출발한경우, 합승해서 특정 정점으로 이동후 해당 정점에서 따로 목적지로 가는 경우를 모두 고려하면 n이 최대 200이므로
 
 200번 반복하면 된다.
 
 다익스트라 증명 : https://gazelle-and-cs.tistory.com/91
 */
