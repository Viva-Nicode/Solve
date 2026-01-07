import Foundation

func solve_1292() {
    let input = readLine()!.components(separatedBy: " ").map { Int($0)! }.sorted()

    var list: [Int] = []

    for l in 1...1000 {
        for _ in 0..<l {
            list.append(l)
        }
    }

    print(list[(input[0] - 1)...(input[1] - 1)].reduce(0) { $0 + $1 })
}

/*
 누적합으로 풀다가 걍 1000개 반복했는데 맞음 ㅋ
 */
