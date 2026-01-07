import Foundation

func solve_1022() {
    let io = FileIO()
    let r1 = io.readInt(), c1 = io.readInt(), r2 = io.readInt(), c2 = io.readInt()
    var answer: [[Int]] = []
    var maxNumber = 1

    for r in r1...r2 {
        answer.append([])

        for c in c1...c2 {

            if r == 0 && c == 0 {
                answer[answer.count - 1].append(1)
                continue
            }

            let m = max(abs(r), abs(c))
            let rd = (m * 2 + 1)^^2

            if abs(r) == m {
                if r > 0 {
                    let add = rd - (m - c)
                    maxNumber = max(maxNumber, add)
                    answer[answer.count - 1].append(add)
                } else {
                    let lu = rd - (2 * m) * 2
                    let add = lu - (m + c)
                    maxNumber = max(maxNumber, add)
                    answer[answer.count - 1].append(add)
                }
            } else {
                if c > 0 {
                    let ru = rd - (2 * m) * 3
                    let add = ru - (m + r)
                    maxNumber = max(maxNumber, add)
                    answer[answer.count - 1].append(add)
                } else {
                    let ld = rd - (2 * m)
                    let add = ld - (m - r)
                    maxNumber = max(maxNumber, add)
                    answer[answer.count - 1].append(add)
                }
            }
        }
    }

    let maxW = String(maxNumber).count
    answer.forEach { print($0.map { String(format: "%\(maxW)d", $0) }.joined(separator: " ")) }
}

/*
 https://www.acmicpc.net/problem/1022
 소용돌이_예쁘게_출력하기.1022
 2025.3.15
 
 특정 좌표가 주어졌을 때 수식을 통해 해당 좌표의 수를 알아낼 수있다.
 
 1을 중심으로 중첩된 동심원(동심정사각형?) 처럼 볼 수 있다.
 
 동심정사각형의 오른쪽 아래 꼭짓점의 수는 r, c중 더큰 절댓값 m이 있을 때 (m * 2 + 1)^2로 구할 수 있다.
 
 */

