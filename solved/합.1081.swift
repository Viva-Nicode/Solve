import Foundation

func solve_1081() {
    let io = FileIO()
    let l = io.readInt(), r = io.readInt()
    var result: Int64 = 0

    let lhs = l == .zero ? 0 : l < 10 ? (0...l).map { Int64(exactly: $0)! }.reduce(0, +): getSummation(l)
    let rhs = r == .zero ? 0 : r < 10 ? (0...r).map { Int64(exactly: $0)! }.reduce(0, +): getSummation(r)
    let includeL = Int64(String(l).map { Int(String($0))! }.reduce(0, +))

    result = rhs - lhs + includeL
    print(result)

    func getSummation(_ n: Int) -> Int64 {
        var result: Int64 = 0
        let ns = String(n)
        var whatthe: [Int64] = [1]

        for _ in 0..<ns.count - 1 { whatthe.append(whatthe.last! * 10) }
        whatthe.reverse()

        for i in 0..<ns.count {
            if i == 0 {
                if Int(ns[i])! != .zero {
                    for nn in 1..<Int(ns[i])! { result += Int64(nn) * whatthe[i] }
                }
                result += Int64(ns[i])! * Int64(ns[1...ns.count - 1])!
            } else if i == ns.count - 1 {
                let dddd = Int(ns[i])! != .zero ? (1...Int(ns[i])!).map { Int(exactly: $0)! }.reduce(0, +) : .zero
                result += Int64(ns[0...ns.count - 2])! * 45 + Int64(dddd)
            } else {
                if Int(ns[i])! != .zero {
                    for ii in 1..<Int(ns[i])! { result += Int64(exactly: Int(exactly: ii)!)! * whatthe[i] }
                }
                result += Int64(ns[i])! * Int64(ns[i + 1...ns.count - 1])! + (45 * whatthe[i] * Int64(ns[0...i - 1])!)
            }
        }
        return result + Int64((0..<ns.count - 1).map { Int(ns[$0])! }.reduce(0, +))
    }
}

/*
 https://www.acmicpc.net/problem/1081
 합.1081
 2025.2.22
 
 3534 -> 50970
 
 일의 자리 : 353 * 45 + (1부터 1의 자릿수까지 더한값) = 353 * 45 + 10 = 15895
 
 십의 자리 : {(1 * 10) + (2 * 10) + (3 * 4)} + 35 * 450 = 15792
 
 십의 자리가 0이다 즉 3504이다 -> 35 * 450 만해준다.
 
 백의 자리 : {(1 * 100) + (2 * 100) + (3 * 100) + (4 * 100) + (5 * 34)} + 4500 * 3 = 14670
 
 마지막 자리 : (1 * 1000) + (2 * 1000) + (3 * 534) = 4602
 
 
 331 -> 3268
 
 일의 자리 : 33 * 45 + 1 = 1485
 
 십의 자리 : ((1 * 10) + (2 * 10) + (3 * 1)) + 3 * 450 = 1383
 
 백의 자리 :(1 * 100)+ (2 * 100) +  (3 * 31) = 393
 
 1485 + 1383 + 393 + (3+3+1) = 3268
 */
