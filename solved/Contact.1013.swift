import Foundation

func solve_1013() {
    let fio = FileIO()
    let tc = fio.readInt()
    let regex = try! NSRegularExpression(pattern: "^(100+1+|01)+$")

    for _ in 0..<tc {
        let input = fio.readString()
        let range = NSRange(location: 0, length: input.count)
        print(regex.firstMatch(in: input, range: range) != nil ? "YES" : "NO")
    }
}
/*
 https://www.acmicpc.net/problem/1013
 허무하네..
 2025.2.17
*/
