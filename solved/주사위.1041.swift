import Foundation

func solve_1041() {
    let n = Int(readLine()!)!
    let dice = readLine()!.components(separatedBy: " ").map { Int($0)! }

    let oneMin = dice.min()!
    let twoMin = [
        [0, 1],
        [0, 2],
        [0, 3],
        [0, 4],
        [5, 1],
        [5, 2],
        [5, 3],
        [5, 4],
        [1, 2],
        [2, 4],
        [3, 4],
        [3, 1]].map { dice[$0[0]] + dice[$0[1]] }.min()!
    let threeMin = [
        [0, 1, 2],
        [0, 2, 4],
        [0, 3, 4],
        [0, 3, 1],
        [5, 1, 2],
        [5, 2, 4],
        [5, 3, 4],
        [5, 3, 1]].map { dice[$0[0]] + dice[$0[1]] + dice[$0[2]] }.min()!

    if n == 1 {
        print(dice.reduce(0) { $0 + $1 } - dice.max()!)
    } else if n == 2 {
        print(threeMin * 4 + twoMin * 4)
    } else {
        let part1 = ((n - 2) * (n - 2)) * oneMin
        let part2 = threeMin * 4
        let part3 = ((n - 2) * 4) * twoMin
        var part4 = 0
        for _ in 0..<n - 1 {
            part4 += (4 * twoMin) + ((n - 2) * 4) * oneMin
        }
        print(part1 + part2 + part3 + part4)
    }
}

/*
 
 최상단에는
 
 (n - 2)^(n - 2)개의 주사위가 한면만 보인다.
 n과 관계없이 4개의 주사위가 3면이 보인다.
 (n - 2) * 4개의 주사위가 두면이 보인다.
 
 최상단의 제외한 나머지 층은
 
 n과 관계없이 4개의 주사위가 두면만 보인다.
 (n - 2) * 4개의 주사위가 한면만 보인다.
 
*/

/*
   3
 4 0 1 5
   2
 
 https://www.acmicpc.net/problem/1041
 2025.1.31
*/


