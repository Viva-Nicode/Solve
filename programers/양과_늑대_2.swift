import Foundation

var _info: [Int] = []
var _edges: [[Int]] = []

func getNextNodes(_ currentNode: Int) -> [Int] {
    var result: [Int] = []
    for elem in _edges { if elem[0] == currentNode { result.append(elem[1]) } }
    return result
}

func dfs(_ count: [Int], _ currentNode: Int, _ visitableNodes: [Int]) -> [Int] {

    var results: [Int] = []
    if count[0] <= count[1] { return [] }

    for visitableNode in visitableNodes {
        // 양과 늑대의 수를 업데이트
        var tempCount: [Int] = count
        tempCount[_info[visitableNode]] += 1
        results.append(tempCount[0])

        // 다음으로 방문가능한 노드배열을 업데이트
        var tempVisitableNodes = visitableNodes + getNextNodes(visitableNode)
        tempVisitableNodes.removeAll(where: { $0 == visitableNode })

        results.append(contentsOf: dfs(tempCount, visitableNode, tempVisitableNodes))
    }
    return results
}

func solution_2(_ info: [Int], _ edges: [[Int]]) -> Int {
    _info = info
    _edges = edges

    let initNextNodes = getNextNodes(0)

    return dfs([1, 0], 0, initNextNodes).max() ?? 0
}

