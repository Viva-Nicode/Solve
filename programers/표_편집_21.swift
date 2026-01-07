import Foundation

class T_Node {
    var up: T_Node?
    var down: T_Node?
    var index: Int = 0

    init(up: T_Node?, down: T_Node?, index: Int) {
        self.up = up
        self.down = down
        self.index = index
    }
}

func solution_21(_ n: Int, _ k: Int, _ cmd: [String]) -> String {
    var result: [String] = Array(repeating: "O", count: n)
    let linkedList: [T_Node] = (0..<n).map { T_Node(up: nil, down: nil, index: $0) }

    linkedList[0].down = linkedList[1]

    for i in 1...n - 2 {
        linkedList[i].up = linkedList[i - 1]
        linkedList[i].down = linkedList[i + 1]
    }

    linkedList[n - 1].up = linkedList[n - 2]
    var cursor: T_Node = linkedList[k]

    var cancels: [T_Node] = []

    for command in cmd {
        let cmdArray = command.components(separatedBy: " ")

        switch cmdArray.first {
        case "U":
            let times = Int(cmdArray[1])!
            for _ in 0..<times {
                cursor = cursor.up! //범위 안의 input만 주어짐
            }
        case "D":
            let times = Int(cmdArray[1])!
            for _ in 0..<times {
                cursor = cursor.down! //범위 안의 input만 주어짐
            }
        case "C":
            result[cursor.index] = "X"
            cancels.append(cursor)

            cursor.up?.down = cursor.down
            cursor.down?.up = cursor.up
            if cursor.down == nil { //마지막 행
                cursor = cursor.up!
            } else {
                cursor = cursor.down!
            }
        case "Z":
            let top = cancels.popLast()!
            result[top.index] = "O"

            top.up?.down = top
            top.down?.up = top

        default: break
        }
    }
    return result.joined()
}
