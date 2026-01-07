import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

func solution_13(_ targets: [[Int]]) -> Int {
    var result = 1, currentIndex = 0
    let sortedTargets = targets.sorted(by: { $0[0] < $1[0] })

    for index in 0..<targets.count {

        guard let nextTarget = sortedTargets[safe: index + 1] else { return result }

        for innerIndex in currentIndex...index {
            if sortedTargets[innerIndex][0]..<sortedTargets[innerIndex][1] ~= nextTarget[0] {
                continue
            } else {
                result += 1
                currentIndex = index + 1
                break
            }
        }
    }
    return result
}

func solution_13_2(_ targets: [[Int]]) -> Int {
    var ans = 0
    let sorted = targets.sorted(by: { $0[1] < $1[1] })

    var end = sorted[0][1]

    for target in sorted {
        if target[0] >= end {
            end = target[1]
            ans += 1
        }
    }
    return ans + 1
}

