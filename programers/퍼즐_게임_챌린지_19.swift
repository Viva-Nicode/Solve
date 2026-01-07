import Foundation

func gettime(_ diffs: [Int], _ times: [Int], _ level: Int) -> Int {
    var time = 0
    for i in 0..<diffs.count {
        if diffs[i] <= level {
            time += times[i]
        } else {
            time += (times[i] + times[i - 1]) * (diffs[i] - level) + times[i]
        }
    }
    return time
}

func solution_19(_ diffs: [Int], _ times: [Int], _ limit: Int64) -> Int {
    var min = 1
    var max = 100000
    var lv = max / 2
    var time: Int = .zero
    var result = Int.max

    for _ in 0...17 {
        time = gettime(diffs, times, lv)
        if limit >= time {
            result = Swift.min(result, lv)
            max = lv
            lv = Swift.max(1, (min + lv) / 2)
        } else {
            min = lv
            lv = Swift.max(1, (lv + max) / 2)
        }
    }
    return Swift.min(result, 100000)
}
