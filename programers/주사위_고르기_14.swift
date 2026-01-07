import Foundation

// 주사위의 갯수 2 <= n <= 10 이고 n은 2의 배수
// 주사위의 원소 1 <= n <= 100
// 주사위 수 구성은 모두 다름

func combination<T: Comparable>(_ array: [T], _ n: Int) -> [[T]] {
    var result = [[T]]()
    if array.count < n { return result }

    var stack = array.enumerated().map { ([$0.element], $0.offset) }

    while stack.count > 0 {
        let now = stack.removeLast()

        let elements = now.0
        let index = now.1

        if elements.count == n {
            result.append(elements.sorted())
            continue
        }

        guard index + 1 <= array.count - 1 else { continue }

        for i in index + 1...array.count - 1 {
            stack.append((elements + [array[i]], i))
        }
    }
    return result
}

func getAllSumation(dice: [[Int]]) -> [Int] {
    var res = [Int]()

    func recursion(index: Int, sum: Int) {
        if index == dice.count {
            res.append(sum)
            return
        }

        for i in 0..<6 {
            recursion(index: index + 1, sum: sum + dice[index][i])
        }
    }

    recursion(index: 0, sum: 0)

    return res
}

func binarySearch(a: [Int], b: [Int]) -> Int {
    let sortedB = b.sorted()
    var winningRate: Int = .zero

    for value in a {
        var low = 0
        var high = sortedB.count

        while low + 1 < high {
            let mid = (low + high) / 2

            if value <= sortedB[mid] {
                high = mid
            } else if value > sortedB[mid] {
                low = mid
            }
        }
        winningRate += low + 1
    }
    return winningRate
}

func solution_14(_ dice: [[Int]]) -> [Int] {

    let count = dice.count
    let combinationResults = combination((0..<count).map { $0 }, count / 2)
    var mwr: Int = .zero
    var result: [Int] = []

    for combinationResult in combinationResults {

        let AsumationList = getAllSumation(dice: combinationResult.map { dice[$0] })
        let BsumationList = getAllSumation(dice: (0..<count).filter { !combinationResult.contains($0) }.map { dice[$0] })
        let wr = binarySearch(a: AsumationList, b: BsumationList)

        if wr > mwr {
            mwr = wr
            result = combinationResult
        }
    }
    return result.map { $0 + 1 }
}
