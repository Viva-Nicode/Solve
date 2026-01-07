import Foundation

func solve_1090() {
    let n = Int(readLine()!)!
    let checkers: [(x: Int, y: Int)] = (0..<n).map { _ in
        let point = readLine()!.components(separatedBy: " ").map { Int($0)! }
        return (x: point[0], y: point[1])
    }

    var ans = [Int](repeating: Int.max, count: n)

    for x in checkers.map({ $0.x }) {
        for y in checkers.map({ $0.y }) {
            var costs: [Int] = []
            for checkerrr in checkers {
                costs.append(abs(x - checkerrr.x) + abs(y - checkerrr.y))
            }
            costs.sort()
            var cost = 0
            for i in 0..<n {
                cost += costs[i]
                ans[i] = min(ans[i], cost)
            }
        }
    }
    print(ans.map { String($0) }.joined(separator: " "))
}

/*
 https://www.acmicpc.net/problem/1090
 체커.1090
 2025.3.3
 
 어떤 3점(x1, y1), (x2, y2), (x3, y3)이 있다고 가정하고 세 점에서 이동 거리의 합이 가장 적은 한점은,
 
 ((x1, x2, x3)의 중앙값, (y1, y2, y3)의 중앙값)이 된다.
 
 즉 n개의 점이 있고, 2이상 n이하 개의 점을 무작위로 선정했을 떄,
 
 선정한 점들에서 이동거리의 합이 가장 적은 한 점이 될수있는 후보 점들의 갯수는 (n * n)개가 된다.
 
 따라서 n이 50이라고 했을 때 50 * 50 = 2500번을 순회하면서,
 
 해당점이 모든 점들의 이동거리의 합이 가장 작은 점이라고 가정했을 때의 각 점들과의 거리를 구한후 정렬한다면
 
 (costs[0] + costs[1])은 최소 두개의 체커를 한자리에 모으려고 했을 때의 두개의 체커의 최소 이동거리의 합이된다.
 
 (costs[0] + costs[1] + costs[2])는 최소 3개의 체커를 한자리에 모르려고 했을 때의 세개의 체커의 최소 이동거리의 합이된다.
 
 정확히는 (n * n)번을 반복하며 min()으로 더 작은 값으로 갱신해주면 된다.
 */

