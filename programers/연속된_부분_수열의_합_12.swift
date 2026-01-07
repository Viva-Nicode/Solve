import Foundation

func solution_12(_ sequence: [Int], _ k: Int) -> [Int] {

    var minLen = Int.max
    var candidates: [[Int]] = []

    for i in 0..<sequence.count {
        for ii in i..<sequence.count {
            if k == sequence[i...ii].reduce(0, +) {
                if ii - i == minLen {
                    candidates.append([i, ii])
                } else if ii - i < minLen {
                    candidates = []
                    minLen = ii - i
                    candidates.append([i, ii])
                }
            } else if k < sequence[i...ii].reduce(0, +) { break }
        }
    }
    candidates.sort(by: { $0[0] < $1[0] })
    return candidates[0]
}

func solution_12_1(_ sequence: [Int], _ k: Int) -> [Int] {

    var ans: [Int] = [0, Int.max]
    var si = 0, ei = 0
    var summation: Int = sequence[0]

    while(true) {

        if k > summation {
            if ei + 1 >= sequence.count { break }
            ei += 1
            summation += sequence[ei]
        } else if k == summation {
            if ans[1] - ans[0] > ei - si {
                ans = [si, ei]
            }
            if ei + 1 >= sequence.count { break }
            ei += 1
            summation += sequence[ei]
        } else if k < summation {
            if si + 1 >= sequence.count { break }
            summation -= sequence[si]
            si += 1
        }
    }
    return ans
}

