import Foundation

func buildDirectedGraph(_ edges: [[Int]]) -> [Int: [Int]] {
    var graph = [Int: [Int]]() // 무방향 그래프 인접 리스트
    var reversedGraph = [Int: [Int]]() // 자식이 부모를 가리키는 방향 그래프
    var visited = Set<Int>() // 방문한 노드를 기록
    let root = 0 // 최상위 부모는 항상 0번 노드

    // 무방향 그래프 생성
    for edge in edges {
        graph[edge[0], default: []].append(edge[1])
        graph[edge[1], default: []].append(edge[0])
    }

    // DFS로 방향 그래프 생성 (0번 노드부터 시작)
    func dfs(_ node: Int) {
        visited.insert(node)

        for neighbor in graph[node, default: []] {
            if !visited.contains(neighbor) {
                reversedGraph[neighbor, default: []].append(node) // 자식이 부모를 가리키도록 설정
                dfs(neighbor)
            }
        }
    }

    dfs(root) // 0번 노드를 루트로 DFS 실행
    return reversedGraph
}

func hasCycle(_ graph: [Int: [Int]], _ node: Int, _ visited: inout Set<Int>, _ stack: inout Set<Int>) -> Bool {

    if stack.contains(node) {
        // 현재 경로에 이미 방문한 노드가 있다면 사이클 존재
        return true
    }

    if visited.contains(node) {
        // 이미 방문했지만 현재 경로에 포함되지 않은 경우는 사이클이 아님
        return false
    }

    // 방문 및 경로 추가
    visited.insert(node)
    stack.insert(node)

    // 현재 노드의 자식 노드들을 탐색
    for neighbor in graph[node] ?? [] {
        if hasCycle(graph, neighbor, &visited, &stack) {
            return true
        }
    }

    // 현재 노드 경로에서 제거
    stack.remove(node)
    return false
}

func solution_31(_ n: Int, _ path: [[Int]], _ order: [[Int]]) -> Bool {

    var directedGraph = buildDirectedGraph(path)
    for o in order { directedGraph[o[1], default: []].append(o[0]) }

    print(directedGraph)
    
    var visited = Set<Int>()
    var stack = Set<Int>()

    for node in 0..<n {
        if !visited.contains(node) {
            if hasCycle(directedGraph, node, &visited, &stack) { return false }
        }
    }
    return true
}

/*
 
 2025.1.27
 
 https://school.programmers.co.kr/learn/courses/30/lessons/67260
 
 path를 순회하면서 좀 쓰기 편하게 인접 리스트 같은거 만들어 놓는다.(요거도 중요할듯)
 
 그다음에 order를 순회하면서 방문을 시작한다.
 
 A order수행이 가능하다면 그대로 수행하고 다음 order인 B order를 수행한다.
 
 만약 B order의 수행중에 또다른 order인 C order의 수행이 필요하다면 C order를 먼저 수행하러 간다. (경로중에 선 방문 필요 노드가 있는지 검사)
 
 만약 C order를 수행중에 D order의 수행이 먼저 필요하다면 이전과 같이 D order를 수행하러간다.(DFS???)
 
 D order 수행중에 B, C order의 수행이 필요한 경우, 즉 이전 수행이 필요하게 되는 모순 사이클이 발생하면 false 그렇지않고 모든 order가 수행 가능하다면 true
 
 는 아니고 위상정렬문제라고 합니다. 정확히는 위상정렬이 가능한가 아닌가를 보는 문제
 
 1. 주어진 그래프를 의존성 방향을 가진 인접 리스트로 바꾼다.
 
 2. 인접 리스트에 order 의존들을 추가해준다.
 
 3. dfs로 노드들을 방문하며 사이클이 있는지 검사.
 */
