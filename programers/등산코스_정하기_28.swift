import Foundation

struct D_Node: Comparable {

    var index: Int
    var value: Int

    static func < (lhs: D_Node, rhs: D_Node) -> Bool {
        lhs.value < rhs.value
    }
}

struct Heap<T:Comparable> {
    var heap: [T] = []

    init(_ dummy: T) {
        heap.append(dummy)
    }

    mutating func append(_ elem: T) {
        heap.append(elem)
        var idx = heap.count - 1
        while idx > 1 && heap[idx] < heap[idx / 2] {
            heap.swapAt(idx, idx / 2)
            idx /= 2
        }
    }

    mutating func getElem() -> T {

        let value = heap[1]

        heap.swapAt(1, heap.count - 1)
        heap.removeLast()

        var idx = 1

        while true {
            let leftChild: T? = idx * 2 < heap.count ? heap[idx * 2] : nil
            let rightChild: T? = idx * 2 + 1 < heap.count ? heap[idx * 2 + 1] : nil

            if leftChild == nil {
                return value
            } else {
                if rightChild == nil {
                    if heap[idx] > leftChild! {
                        heap.swapAt(idx, idx * 2)
                        idx = idx * 2
                    } else {
                        return value
                    }
                } else {
                    let cidx = leftChild! > rightChild! ? idx * 2 + 1: idx * 2

                    if heap[cidx] < heap[idx] {
                        heap.swapAt(idx, cidx)
                        idx = cidx
                    } else {
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

// 제출된 정답코드
func solution_28(_ n: Int, _ paths: [[Int]], _ gates: [Int], _ summits: [Int]) -> [Int] {
    var graph = [[(Int, Int)]](repeating: [], count: n + 1)
    var intensity = [Int](repeating: Int.max, count: n + 1)
    let gateSet = Set(gates), summitSet = Set(summits)
    var result = (summit: Int.max, intensity: Int.max)

    // 인접 리스트 생성
    for path in paths {
        let u = path[0], v = path[1], w = path[2]
        graph[u].append((v, w))
        graph[v].append((u, w))
    }

    var heap = Heap<D_Node>(D_Node(index: 0, value: 0))

    for gate in gates {
        heap.append(D_Node(index: gate, value: 0))
        // intensity[i]에는 i에 도달하기 까지 발생한 비용중 가장 큰값(intensity)들중 가장 작은값이 저장된다.
        intensity[gate] = 0
    }

    while !heap.isEmpty {
        let vertex = heap.getElem()

        // 현재 경로의 intensity가 기존 intensity보다 크면 스킵
        if vertex.value > intensity[vertex.index] {
            continue
        }

        // Summit에 도달한 경우 결과 갱신
        if summitSet.contains(vertex.index) {
            if vertex.value < result.intensity || (vertex.value == result.intensity && vertex.index < result.summit) {
                result = (summit: vertex.index, intensity: vertex.value)
            }
            continue
        }

        // 인접 노드 탐색
        for (next, cost) in graph[vertex.index] {
            let maxCost = max(vertex.value, cost)

            // 게이트는 다시 방문하지 않으며, 최소 intensity를 갱신할 경우에만 추가
            if !gateSet.contains(next) && maxCost < intensity[next] {
                intensity[next] = maxCost
                heap.append(D_Node(index: next, value: maxCost))
            }
        }
    }

    return [result.summit, result.intensity]
}

// 힙 대신 큐를 사용한 코드
// 이거도 통과되기는 하지만 이론상 힙을 사용했을 때보다 복잡도가 증가한다.
func solution_28_2(_ n: Int, _ paths: [[Int]], _ gates: [Int], _ summits: [Int]) -> [Int] {
    var graph = [[(Int, Int)]](repeating: [], count: n + 1)
    var intensity = [Int](repeating: Int.max, count: n + 1)
    let gateSet = Set(gates), summitSet = Set(summits)
    var result = (summit: Int.max, intensity: Int.max)
    var queue = [(index: Int, value: Int)]()

    // 인접 리스트 생성
    for path in paths {
        let u = path[0], v = path[1], w = path[2]
        graph[u].append((v, w))
        graph[v].append((u, w))
    }

    // 게이트 초기화
    for gate in gates {
        queue.append((index: gate, value: 0))
        intensity[gate] = 0
    }

    // BFS 탐색
    while !queue.isEmpty {
        let vertex = queue.removeFirst()

        // 현재 경로의 intensity가 기존 intensity보다 크면 스킵
        if vertex.value > intensity[vertex.index] {
            continue
        }

        // Summit에 도달한 경우 결과 갱신
        if summitSet.contains(vertex.index) {
            if vertex.value < result.intensity || (vertex.value == result.intensity && vertex.index < result.summit) {
                result = (summit: vertex.index, intensity: vertex.value)
            }
            continue
        }

        // 인접 노드 탐색
        for (next, cost) in graph[vertex.index] {
            let maxCost = max(vertex.value, cost)

            // 게이트는 다시 방문하지 않으며, 최소 intensity를 갱신할 경우에만 추가
            if !gateSet.contains(next) && maxCost < intensity[next] {
                intensity[next] = maxCost
                queue.append((index: next, value: maxCost))
            }
        }
    }
    return [result.summit, result.intensity]
}

// 아래는 스스로 작성한 오답
func wrongSolution(_ n: Int, _ paths: [[Int]], _ gates: [Int], _ summits: [Int]) -> [Int] {

    var table: [Int: [D_Node]] = [:]
    var heap = Heap<D_Node>(D_Node(index: 0, value: -1))
    let gateSet = Set(gates)
    let summitSet = Set(summits)
    var result: [Int] = [Int.max, Int.max]

    for path in paths {
        table[path[0], default: []].append(D_Node(index: path[1], value: path[2]))
        table[path[1], default: []].append(D_Node(index: path[0], value: path[2]))
    }

    for gate in gates {
        heap.append(D_Node(index: gate, value: .zero))
    }

    while !heap.isEmpty {
        let node = heap.getElem()

        if result[1] < node.value {
            continue
        }

        // 봉우리 도착
        if summitSet.contains(node.index) {
            if result[1] > node.value {
                result[1] = node.value
                result[0] = node.index
            } else if result[1] == node.value {
                if result[0] > node.index {
                    result[1] = node.value
                    result[0] = node.index
                }
            }
            continue
        }

        for vertex in table[node.index]! {
            if !gateSet.contains(vertex.index) {
                if result[1] > max(node.value, vertex.value) {
                    heap.append(D_Node(index: vertex.index, value: max(node.value, vertex.value)))
                }
            }
        }
    }

    return result
}

/*
 어느 한 시작정점에서 intensity가 최소가 되는 방법으로 봉우리에 도착했다면 시작정점이 어디였었던것과는 관계없이
 봉우리에서 다시 시작정점으로 가는 경로는 같으므로 돌아올 필요 없이 시작정점에서 봉우리 까지만 탐색하면 된다.
 
 노드수가 5만으로 크므로 인접 행렬리 아닌 리스트로 구성한다.
 
 아래 3줄의 아이디어가 제일 중요했던거 같다.
 
 최단 거리의 정의를 노든 비용의 합이 아닌 비용중 가장 큰 값으로 바꿔도 다익스트라가 제대로 동작한다.
 
 시작 정점마다 한번씩 다익스트라를 수행하는 것이 아닌 힙하나에 모든 시작정점을 넣고 다익스트라를 수행한다.
 
 해당 노드에 n의 intensity로 도달한 노드가 있다면 다른 노드가 n+1로 같은 노드에 도달한 경우 더이상 탐색할 필요가없는 경로이므로 제거.
 
 봉우리에 도착한경우 값을 저장하고 해당 경로는 더이상 탐색 중지
 
 다익스트라와 다른점.
 
 1. 시작정점이 여러개이다.
 2. 모든 정점까지의 최단 거리를 구하는 것이 아닌 모든 정점중 특정 정점들 까지의 최단 거리를 구한다.
 3. visited 배열을 사용하지 않는다. 즉 특정 조건만 만족한다면 한번 방문한 정점을 재방문할 수 있다.
 4. 주어진 비용중 최소비용을 먼저 탐색하지 않아도된다.(힙을 사용하지 않아도 된다.)
 
 */
