import Foundation

func zeroStone(_ stones: [Int]) -> Int {

    var count = 0
    var maxCount = 0

    for stone in stones {
        if stone <= 0 {
            count += 1
        } else {
            maxCount = max(count, maxCount)
            count = 0
        }
    }
    return maxCount
}

// 직관적으로 선형탑색하면서 푼거
func solution_15(_ stones: [Int], _ k: Int) -> Int {
    var count = 0
    var tempStones = stones
    while true {
        let zeroLen = zeroStone(tempStones)
        if zeroLen >= k { return count }

        let positiveNumbers = tempStones.filter { $0 > 0 }
        let min = positiveNumbers.min() ?? 0
        for index in 0..<tempStones.count { tempStones[index] -= min }
        count += min
    }
    return count
}

// 이진 탐색으로 푼거
func solution_15_2(_ stones: [Int], _ k: Int) -> Int {
    var s = 0, e = stones.max() ?? 0

    while e - s != 1 {

        let m = (s + e) / 2
        var cnt = 0
        var w = true

        for index in 0..<stones.count {
            if stones[index] - m <= 0 {
                cnt += 1
                if cnt == k {
                    e = m
                    w = true
                    break
                }
            } else {
                w = false
                cnt = 0
            }
        }
        if !w { s = m }
    }
    return e
}
