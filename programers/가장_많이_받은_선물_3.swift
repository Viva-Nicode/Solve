import Foundation

func solution_3(_ friends: [String], _ gifts: [String]) -> Int {
    var dic: [String: Int] = [:]
    var t: [String: [String: Int]] = [:]
    var result = 0

    for friend in friends { t[friend] = Dictionary(uniqueKeysWithValues: friends.map { ($0, 0) }) }

    for rec in gifts {
        let p = rec.components(separatedBy: " ")
        dic[p[0], default: 0] += 1
        dic[p[1], default: 0] -= 1
        t[p[0]]![p[1]]! += 1
    }

    for friend in friends {
        var ir = 0
        friends.forEach {
            let l = t[friend]![$0]!
            let r = t[$0]![friend]!
            if l > r {
                ir += 1
            } else if l == r {
                if dic[friend] ?? 0 > dic[$0] ?? 0 {
                    ir += 1
                }
            }
        }
        result = max(ir, result)
    }
    return result
}
