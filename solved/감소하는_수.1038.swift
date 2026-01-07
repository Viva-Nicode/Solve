import Foundation

func solve_1038() {
    let n = FileIO().readInt()
    var incresses: [Int64] = [0]

    (1...10).forEach { dfs(0, [Int](repeating: 0, count: $0)) }

    func dfs (_ nod: Int, _ number: [Int]) {

        if nod >= number.count {
            incresses.append(Int64(number.map { String($0) }.joined())!)
            return
        }

        if nod == .zero {
            for ablen in 1...9 {
                var temp = number
                temp[nod] = ablen
                dfs(nod + 1, temp)
            }
        } else {
            for ablen in 0..<number[nod - 1] {
                var temp = number
                temp[nod] = ablen
                dfs(nod + 1, temp)
            }
        }
    }

    print(n < incresses.count ? incresses[n] : -1)
}

/*
 https://www.acmicpc.net/problem/1038
 2025.2.19
 
 Perfect Solved
 
 DFS를 통한 완전 탐색해서 1자리부터 10자리까지 모든 감소하는 수를 구하면 된다.
 
 의외로 10자리일때 감소하는 수는 단하나이다. 9876543210 밖에 없다.
 
 때문에 생각보다 감소하는수는 많지않다. 전부 탐색해도 될 정도로.
 
 */
