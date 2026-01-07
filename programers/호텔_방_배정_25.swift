import Foundation

/// k는 1,000,000,000,000
/// room_number는 200,000

func solution_25(_ k: Int64, _ room_number: [Int64]) -> [Int64] {
    var d: [Int64: Int64] = [:]
    var r: [Int64] = Array(repeating: .zero, count: room_number.count)

    for i in 0..<room_number.count {
        if d[room_number[i]] != nil {
            var nn: Int64 = room_number[i]
            while d[nn] != nil {
                let nnn = nn
                nn = d[nn]!
                d[nnn] = d[nnn]! + 1
            }
            r[i] = nn
            d[nn] = nn + 1
        } else {
            r[i] = room_number[i]
            d[room_number[i]] = room_number[i] + 1
        }
    }
    return r
}

var room: [Int64: Int64] = [:]

func findRoomNumber(_ index: Int64) -> Int64 { //빈 방을 return
    guard let nextRoomNumber = room[index] else { //방이 비어있을 경우
        room[index] = index + 1

        return index
    }

    //방이 차있을 경우
    let nextBlankNumber = findRoomNumber(nextRoomNumber)
    room[index] = nextBlankNumber + 1 //다음 비어 있는 방 표시

    return nextBlankNumber
}

func solution2(_ k: Int64, _ room_number: [Int64]) -> [Int64] {
    let result: [Int64] = room_number.map { findRoomNumber($0) }

    return result
}
