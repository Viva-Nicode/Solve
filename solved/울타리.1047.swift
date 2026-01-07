import Foundation

func solve_1047() {
    let n = Int(readLine()!)!

    var x = [Int](repeating: 0, count: n)
    var y = [Int](repeating: 0, count: n)
    var nfence = [Int](repeating: 0, count: n)
    var xsort = [Int](repeating: 0, count: n)
    var ysort = [Int](repeating: 0, count: n)

    for i in 0..<n {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        x[i] = input[0]
        y[i] = input[1]
        nfence[i] = input[2]
        xsort[i] = x[i]
        ysort[i] = y[i]
    }

    xsort.sort()
    ysort.sort()

    var res = n
    var inFences = [Int]()

    for a in 0..<n {
        for b in a..<n {
            for c in 0..<n {
                for d in c..<n {
                    var ntree = 0
                    var outSum = 0
                    var inSum = 0
                    let need = 2 * (xsort[b] - xsort[a] + ysort[d] - ysort[c])

                    for i in 0..<n {
                        if x[i] >= xsort[a] && x[i] <= xsort[b], y[i] >= ysort[c] && y[i] <= ysort[d] {
                            ntree += 1
                            inFences.append(nfence[i])
                            inSum += nfence[i]
                        } else {
                            outSum += nfence[i]
                        }
                    }

                    if outSum >= need {
                        res = min(res, n - ntree)
                    } else {
                        if outSum + inSum >= need {
                            inFences.sort(by: >)
                            for fence in inFences {
                                ntree -= 1
                                outSum += fence
                                if outSum >= need {
                                    res = min(res, n - ntree)
                                    break
                                }
                            }
                        }
                    }
                    inFences.removeAll()
                }
            }
        }
    }
    print(res)
}

/*
 https://www.acmicpc.net/problem/1047
 울타리.1047
 2025.3.5
 
 점들로 만들수있는 모든 직사각형을 n * (n(n+1)/2) * n * (n(n+1)/2) 복잡도로 구한다.
 
 직사각형 밖을 싹다 벌목한다. 울타리를 만들기 부족하면 내부도 벌목한다.
 
 울타리가 완성되면 벌목한 나무 수를 min으로저장한다. 그래도 나무가 부족한 경우는 패스.
 
 */

