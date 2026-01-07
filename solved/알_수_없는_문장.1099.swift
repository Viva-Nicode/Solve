import Foundation

func solve_1099() {

    func check(_ w1: [Character], _ w2: [Character], _ length: Int) -> Int {
        var count = 0
        for i in 0..<length {
            if w1[i] != w2[i] {
                count += 1
            }
        }
        return count
    }

    let input = readLine()!
    let s = " " + input.trimmingCharacters(in: .whitespacesAndNewlines)
    let n = Int(readLine()!)!
    var words: [[Character]] = []
    for _ in 0..<n {
        words.append(Array(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)))
    }

    let sArray = Array(s)
    let sLength = sArray.count

    var dp = [[Int]](repeating: [Int](repeating: 1000, count: sLength), count: sLength)
    dp[0][0] = 0

    for i in 1..<sLength {
        if dp[i - 1][0] == 1000 { continue }

        for word in words {
            let length = word.count
            if i + length - 1 >= sLength { continue }

            if sArray[i..<(i + length)].sorted() == word.sorted() {
                dp[i][i + length - 1] = min(dp[i][i + length - 1], dp[i - 1][0] + check(Array(sArray[i..<(i + length)]), word, length))
                dp[i + length - 1][0] = min(dp[i + length - 1][0], dp[i][i + length - 1])
            }
        }
    }

    if dp[sLength - 1][0] != 1000 {
        print(dp[sLength - 1][0])
    } else {
        print(-1)
    }
}

/*
 https://www.acmicpc.net/problem/1099
 알_수_없는_문장.1099
 2025.3.12
 
 */

