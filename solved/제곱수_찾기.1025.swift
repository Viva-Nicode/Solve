import Foundation

func solve_1025() {
    let io = FileIO()
    let n = io.readInt(), m = io.readInt()
    let table = (0..<n).map { _ in io.readString().map { Int(String($0))! } }
    var ans = -1

    // 96퍼 틀은 아래 조건문 삽입시 통과된다.
    if n == 1, m == 1 {
        let dd = Int(sqrt(Double(table[0][0])))
        if dd * dd == table[0][0] {
            print(table[0][0])
        } else {
            print(-1)
        }
        return
    }

    for r in 0..<n {// r의 초항 인덱스
        for c in 0..<m { // c의 초항 인덱스
            for rcd in -n + 1..<n { // r의 공차
                // 등차수열의 두번째 항이 row인덱스를 벗어나는 경우 continue
                if !(0..<n ~= r + rcd) { continue }
                for ccd in -m + 1..<m { // c의 공차
                    // 등차수열의 두번째 항이 colunm인덱스를 벗어나는 경우 continue
                    if !(0..<m ~= c + ccd) { continue }
                    // 공차가 전부 0이어서 무한 수열이 되는경우 continue
                    if rcd == 0 && ccd == 0 { continue }
                    var nr = r, nc = c
                    var seq: [Int] = [table[nr][nc]]

                    while true {
                        if 0..<n ~= nr + rcd && 0..<m ~= nc + ccd {
                            nr += rcd
                            nc += ccd
                            seq.append(table[nr][nc])
                        } else {
                            break
                        }
                    }

                    // 만들어진 등차수열의 부분수열들을 검사
                    for i in stride(from: seq.count, through: 1, by: -1) {
                        for j in 0..<seq.count - i + 1 {
                            let num = Int(seq[j..<j + i].map { String($0) }.joined())!
                            let d = Int(sqrt(Double(num)))
                            if d * d == num {
                                ans = max(ans, num)
                            }
                        }
                    }
                }
            }
        }
    }
    print(ans)
}

/*
 https://www.acmicpc.net/problem/1025
 제곱수_찾기.1025
 2025.3.21
 
 모든 경우를 완전탐색
 
 */


