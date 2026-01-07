import Foundation

func solve_1083() {
    let _ = readLine()!
    var list = readLine()!.components(separatedBy: " ").map { Int($0)! }
    var s = Int(readLine()!)!

    for i in 0..<list.count {
        let maxNumber = list[i...min(i + s, list.count - 1)].max()!
        let maxNumberIndex = list.firstIntIndex(of: maxNumber)!
        if i == maxNumberIndex { continue }
        let d = list.remove(at: maxNumberIndex)
        list.insert(d, at: i)
        s -= maxNumberIndex - i
        if s <= 0 { break }
    }
    print(list.map { String($0) }.joined(separator: " "))
}

/*
 https://www.acmicpc.net/problem/1083
 소트.1083
 2025.2.25
 
 매우 쉽게 거의 30분만에 푼 문제
 
 그냥 내추럴하게 풀면 된다.
 0번째 수부터 0 + s까지의 수중 제일 큰수를 계속 앞으로 보내면 된다.
 
 */
