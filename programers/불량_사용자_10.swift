import Foundation

var resultSet: Set<Set<String>> = []
var memoDic: [String: Bool] = [:]

func isEqual(_ bid: String, _ uid: String) -> Bool {

    if let df = memoDic[bid + "+" + uid] { return df }

    let pattern = "^" + bid.replacingOccurrences(of: "*", with: ".") + "$"

    if let regex = try? NSRegularExpression(pattern: pattern) {
        let range = NSRange(location: 0, length: uid.utf16.count)
        let v = regex.firstMatch(in: uid, options: [], range: range) != nil
        memoDic[bid + "+" + uid] = v
        return v
    }
    return false
}

func dfs(_ ary: [[String]], _ s: [String], _ count: Int) {

    if ary.count <= count {
        let tlqkf = Set(s)
        if tlqkf.count == ary.count { resultSet.insert(tlqkf) }
        return
    }

    for i in 0..<ary[count].count {
        if s.contains(ary[count][i]) { continue }
        dfs(ary, s + [ary[count][i]], count + 1)
    }
}

func solution_10(_ user_id: [String], _ banned_id: [String]) -> Int {

    var stringSets = [[String]]()

    for bid in 0..<banned_id.count {
        var set: [String] = []
        for uid in 0..<user_id.count { if isEqual(banned_id[bid], user_id[uid]) { set.append(user_id[uid]) } }
        stringSets.append(set)
    }

    dfs(stringSets, [], 0)
    return resultSet.count
}
