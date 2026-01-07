import Foundation

func solve_2252() {
    let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
    var answer: [Int] = []
    var list: [[Int]] = []
    
    for i in 0..<input[1] {
        var comp = readLine()!.components(separatedBy: " ").map { Int($0)! }
        answer.append(comp[0])
        answer.append(comp[1])
    }
}

/*
 https://www.acmicpc.net/problem/2252
 
 
 */
