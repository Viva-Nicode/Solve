import Foundation

extension String {
    var transferStringToSec: Int {
        let d = self.components(separatedBy: ":")
        return Int(d[0])! * 60 + Int(d[1])!
    }
}

extension Int {
    var transferSecToString: String {
        let m = self / 60
        let s = self % 60
        let mm = m / 10 == .zero ? "0\(m)" : "\(m)"
        let ss = s / 10 == .zero ? "0\(s)" : "\(s)"
        return "\(mm):\(ss)"
    }
}

func solution_8(_ video_len: String, _ pos: String, _ op_start: String, _ op_end: String, _ commands: [String]) -> String {
    var result = pos.transferStringToSec
    let start = op_start.transferStringToSec
    let end = op_end.transferStringToSec
    let len = video_len.transferStringToSec

    if start...end ~= result {
        result = end
    }

    for command in commands {
        switch command {
        case "next":
            result = min(len, result + 10)
        case "prev":
            result = max(.zero, result - 10)
        default:
            break
        }
        if start...end ~= result {
            result = end
        }
    }
    return result.transferSecToString
}
