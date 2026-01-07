import Foundation

func solution_30(_ s: String) -> Int {

    var ns = ""
    var result = ""
    let dic = ["zero": "0", "one": "1", "two": "2", "three": "3", "four": "4", "five": "5",
        "six": "6", "seven": "7", "eight": "8", "nine": "9"]

    s.forEach { c in
        if c.isNumber {
            result.append(c)
        } else {
            ns.append(c)
            if dic[ns] != nil {
                result.append(dic[ns]!)
                ns = ""
            }
        }
    }

    return Int(result)!
}
