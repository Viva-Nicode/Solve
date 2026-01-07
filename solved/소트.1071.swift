import Foundation

func solve_1071() {
    let _ = Int(readLine()!)!
    var numbers = readLine()!.components(separatedBy: " ").map { Int($0)! }
    var ans: [Int] = [1000]

    while !numbers.isEmpty {
        let cands = numbers.enumerated().filter { $0.element != ans[ans.count - 1] + 1 }
        if cands.isEmpty {
            let minn = numbers.enumerated().min(by: { $0.element < $1.element })!
            for i in stride(from: ans.count - 1, through: 0, by: -1) {
                if i > 0 {
                    if minn.element + 1 != ans[i], ans[i - 1] + 1 != minn.element {
                        ans.insert(minn.element, at: i)
                        numbers.remove(at: minn.offset)
                        break
                    }
                } else {
                    if minn.element + 1 != ans[i] {
                        ans.insert(minn.element, at: i)
                        numbers.remove(at: minn.offset)
                        break
                    }
                }
            }
        } else {
            let next = cands.min(by: { $0.element < $1.element })!
            ans.append(next.element)
            numbers.remove(at: next.offset)
        }
    }
    print(ans[1..<ans.count].map { String($0) }.joined(separator: " "))
}

/*
 https://www.acmicpc.net/problem/1071
 소트.1071
 2025.3.6
 Perfect Solved
 
 그리디이다.
 그냥 수들중 가장 작은 수중에 조건(array[i - 1] + 1 != array[i])을 만족하는 수를 맨앞에 놓는다.
 그러다가 남은 수들 중 조건을 만족하는 수가 없으면 남은 수들중 가장 작은수를 ans를 거꾸로 탐색하면서 조건을 만족하는 최초의 위치에 끼워넣는다.
 플레티넘 난이도는 아닌거같다.
 
 */
