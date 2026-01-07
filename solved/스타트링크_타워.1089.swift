import Foundation

func solve_1089() {
    let n = Int(readLine()!)!
    let input = (0..<5).map { _ in readLine()!.map { String($0) } }
    var wtf: [[Int]] = []
    var ans = Double.zero
    let nns = [
        [(1, 1), (2, 1), (3, 1)],
        [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (3, 0), (3, 1), (4, 0), (4, 1)],
        [(1, 0), (1, 1), (3, 1), (3, 2)], [(1, 0), (1, 1), (3, 0), (3, 1)],
        [(0, 1), (1, 1), (3, 0), (3, 1), (4, 0), (4, 1)], [(1, 1), (1, 2), (3, 0), (3, 1)],
        [(1, 1), (1, 2), (3, 1)], [(1, 0), (1, 1), (2, 0), (2, 1), (3, 0), (3, 1), (4, 0), (4, 1)],
        [(1, 1), (3, 1)], [(1, 1), (3, 0), (3, 1)]
    ]
    var idx = 0

    while idx <= (n * 3) + n - 1 {
        let numberSegments = input.map { Array($0[idx...idx + 2]) }
        var ableNumbers: [Int] = []

        for ni in 0..<nns.count {
            if nns[ni].allSatisfy({ numberSegments[$0.0][$0.1] == "." }) {
                ableNumbers.append(ni)
            }
        }

        if ableNumbers.isEmpty {
            print(-1)
            return
        }
        wtf.append(ableNumbers)
        idx += 4
    }

    for i in 0..<wtf.count {
        ans += Double(wtf[i].reduce(0, +)) / Double(wtf[i].count) * Double("\(1)\(String(repeating: "0", count: wtf.count - i - 1))")!
    }
    print(ans)
}

/*
 https://www.acmicpc.net/problem/1089
 스타트링크_타워.1089
 2025.2.26
 
 각 자리마다 가능한 숫자들을 구해내는 것은 쉬웠다.
 
 N이 10이고 각 자리마다 0 ~ 9 까지 전부 가능하다고 한다면 총 100억개의 수의 평균을 구해야 하므로 시간초과가 발생한다.
 
 처음에는 가능한 수들의 조합을 DFS로 구하고 평균을 구해서 시간초과가 발생했지만,
 
 평균을 구하는 공식이 있었다.
 
 for i in 0..<wtf.count {
     ans += Double(wtf[i].reduce(0, +)) / Double(wtf[i].count) * Double("\(1)\(String(repeating: "0", count: wtf.count - i - 1))")!
 }
 
 이렇게 바꾸고 통과.
 */

