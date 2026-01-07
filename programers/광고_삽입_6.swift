import Foundation

extension String {
    var convertToSec: Int {
        let parsed = self.components(separatedBy: ":")
        return Int(parsed[0])! * 3600 + Int(parsed[1])! * 60 + Int(parsed[2])!
    }
}

extension Int {
    var convertToString: String {
        print(self)
        return "\(self / 3600):\(self % 3600 / 60):\(self % 3600 % 60)"
    }
}

func solution_6(_ play_time: String, _ adv_time: String, _ logs: [String]) -> String {
    let play_time_sec = play_time.convertToSec
    let adv_time_sec = adv_time.convertToSec
    var logs_start_sec: [Int] = Array(repeating: -1, count: logs.count)
    var logs_end_sec: [Int] = Array(repeating: -1, count: logs.count)
    var total_time: [Int] = Array(repeating: -1, count: 360000)
    var max_time = Int.zero

    for (i, log) in logs.enumerated() {
        let startToEnd = log.components(separatedBy: "-")
        logs_start_sec[i] = startToEnd[0].convertToSec
        logs_end_sec[i] = startToEnd[1].convertToSec
    }

    for (i, _) in logs.enumerated() {
        total_time[logs_start_sec[i]] = total_time[logs_start_sec[i]] + 1
        total_time[logs_end_sec[i]] = total_time[logs_end_sec[i]] - 1
    }

    for i in 1...play_time_sec {
        total_time[i] = total_time[i] + total_time[i - 1]
    }

    for i in 1...play_time_sec {
        total_time[i] = total_time[i] + total_time[i - 1]
    }

    for i in adv_time_sec - 1...play_time_sec - 1 {
        if i >= adv_time_sec {
            max_time = max(max_time, total_time[i] - total_time[i - adv_time_sec])
        } else {
            max_time = max(max_time, total_time[i])
        }
    }

    return max_time.convertToString
}
//이거는 실패함
