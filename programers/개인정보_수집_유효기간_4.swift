import Foundation

func solution_4(_ today: String, _ terms: [String], _ privacies: [String]) -> [Int] {
    let parsedToday = today.components(separatedBy: ".")
    let t = Int(parsedToday[0])! * 12 * 28 + Int(parsedToday[1])! * 28 + Int(parsedToday[2])!
    var result: [Int] = []
    for (i, privacie) in privacies.enumerated() {
        let splited = privacie.components(separatedBy: " ")
        let ddd = splited[0]
        let kindofprivate = splited[1]
        let dddd = ddd.components(separatedBy: ".")
        var validLimit = Int(dddd[0])! * 12 * 28 + Int(dddd[1])! * 28 + Int(dddd[2])!

        let asdf = Int(terms.filter { $0.components(separatedBy: " ")[0] == kindofprivate }.first!.components(separatedBy: " ")[1])! * 28

        validLimit += asdf
        if validLimit <= t {
            result.append(i + 1)
        }
    }
    return result
}
