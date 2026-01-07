import Foundation

func solution_29(_ survey: [String], _ choices: [Int]) -> String {
    var result: [String: Int] = [:]

    for i in 0..<choices.count {
        if choices[i] - 4 < 0 {
            result[String(survey[i].first!), default: 0] += abs(choices[i] - 4)
        } else {
            result[String(survey[i].last!), default: 0] += choices[i] - 4
        }
    }

    return "\(result["R", default: 0] >= result["T", default: 0] ? "R" : "T")\(result["C", default: 0] >= result["F", default: 0] ? "C" : "F")\(result["J", default: 0] >= result["M", default: 0] ? "J" : "M")\(result["A", default: 0] >= result["N", default: 0] ? "A" : "N")"
}
