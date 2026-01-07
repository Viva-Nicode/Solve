import Foundation

func solution_9(_ gems: [String]) -> [Int] {
    let kinds = Set(gems)
    var dic: [String: Int] = [:]

    var lidx = 0, ridx = 0
    var d = true
    var result: [Int] = [0, gems.count]

    while true {
        if lidx >= gems.count || ridx >= gems.count { break }

        if d {
            dic[gems[ridx], default: 0] += 1
        } else {
            dic[gems[lidx - 1]]! -= 1
            if dic[gems[lidx - 1]]! <= 0 { dic.removeValue(forKey: gems[lidx - 1]) }
        }

        if dic.count == kinds.count { // 조건에 부합한다면
            if result[1] - result[0] > ridx - lidx { result = [lidx + 1, ridx + 1] }
            if lidx == ridx {
                ridx += 1
                d = true
            } else {
                lidx += 1
                d = false
            }
        } else { // 부합하지 않는다면
            ridx += 1
            d = true
        }
    }
    return result
}
