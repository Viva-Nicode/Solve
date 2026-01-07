import Foundation

func solve_1365() {
    let n = Int(readLine()!)!
    let telephonePoles = readLine()!.components(separatedBy: " ").map { Int($0)! }
    var lis: [Int] = []

    lis.append(telephonePoles.first!)

    for i in 1..<telephonePoles.count {
        if telephonePoles[i] >= lis.last! {
            lis.append(telephonePoles[i])
        } else {
            var left = 0
            var right = lis.count - 1

            while left < right {
                let mid = (left + right) / 2
                if lis[mid] < telephonePoles[i] {
                    left = mid + 1
                } else {
                    right = mid
                }
            }
            lis[right] = telephonePoles[i]
        }
    }
    print(n - lis.count)
}

/*
 https://www.acmicpc.net/problem/1365
 최장 증가 부분 수열을 n log n으로 찾을 수 있다.
 
 */
