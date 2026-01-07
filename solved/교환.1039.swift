import Foundation

func solve_1039() {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    var check = Array(repeating: Array(repeating: false, count: 11), count: 1000001)
    let len = String(input[0]).count
    var mx = 0
    var queue = [(String(input[0]).map { String($0) }, 0)]
    var q = 0

    while queue.count > q {
        let f = queue[q]
        q += 1
        if f.1 == input[1] {
            mx = max(mx, Int(f.0.joined())!)
            continue
        }
        for i in 0..<len {
            for j in i + 1..<len {
                var tempt = f.0
                tempt.swapAt(i, j)
                if tempt[0] == "0" { continue }
                let x = Int(tempt.joined())!
                if check[x][f.1 + 1] { continue }
                check[x][f.1 + 1] = true
                queue.append((tempt, f.1 + 1))
            }
        }
    }
    print(mx == 0 ? -1 : mx)
}

/*
 https://www.acmicpc.net/problem/1039
 2025.2.13
 
 너비 우선을 통한 완전 탐색 + 특정경우는 탐색하지 않는 가지치기
 
 
 */
