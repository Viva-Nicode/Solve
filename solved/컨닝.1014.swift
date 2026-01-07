import Foundation

func solve_1014() {
    let io = FileIO()
    let tc = io.readInt()
    var ans = ""

    for _ in 0..<tc {
        let n = io.readInt(), m = io.readInt()
        var dp: [[Int]] = [[Int]](repeating: [Int](repeating: -1, count: 2^^m + 1), count: n)
        let classRoom: [[String]] = (0..<n).map { _ in io.readString().map { String($0) } }

        var lines: [String] = []
        var dfsList: [Int] = [Int](repeating: 0, count: m)
        ddfs(&lines, &dfsList, 0, m)
        lines.sort(by: { Int($0, radix: 2)!.nonzeroBitCount > Int($1, radix: 2)!.nonzeroBitCount })

        dfs(n - 1, 0, classRoom, 0)
        ans += "\(dp[0].max()!)\n"

        func dfs(_ floor: Int, _ prevFloorArrangement: Int, _ classRoom: [[String]], _ students: Int) {
            if floor < 0 { return }

            for vv in lines {
                let vvv = vv.map { String($0) }

                if !(classRoom[floor].enumerated().allSatisfy({ !($1 == "x" && vvv[$0] == "1") })) {
                    continue
                }

                var isable = true

                for di in 0..<vvv.count {

                    if vvv[di] == "x" || vvv[di] == "0" {
                        continue
                    }

                    if di < vvv.count - 1 {
                        if vvv[di] == "1" && (prevFloorArrangement & (1 << (m - (di + 2)))) != 0 {
                            isable = false
                            break
                        }
                    }

                    if di > 0 {
                        if vvv[di] == "1" && prevFloorArrangement & (1 << (m - di)) != 0 {
                            isable = false
                            break
                        }
                    }
                }

                let sitc = vvv.filter { $0 == "1" }.count + students
                let arraCase = Int(vvv.map { $0 == "x" ? "0": $0 }.joined(), radix: 2)!

                if isable && dp[floor][arraCase] < sitc {
                    dp[floor][arraCase] = sitc
                    dfs(floor - 1, arraCase, classRoom, sitc)
                }
            }
        }
    }

    func ddfs(_ lines: inout [String], _ dfsList: inout [Int], _ index: Int, _ m: Int) {

        if m == index {
            var str = ""
            for ll in dfsList {
                str += String(ll)
            }
            lines.append(str)
            return
        }

        dfsList[index] = 0
        ddfs(&lines, &dfsList, index + 1, m)

        if 0 < index && dfsList[index - 1] != 0 {
            return
        }

        dfsList[index] = 1
        ddfs(&lines, &dfsList, index + 1, m)
    }
    print(ans)
}

/*
 https://www.acmicpc.net/problem/1014
 컨닝.1014
 2025.3.1
 
 비트마스크, DP, DFS
 
 교실의 가장 아래 한행 부터 위 행으로 올라가면서 가장 많이 앉을 수있는 행 배치의 크기를 구한다.
 
 먼저 DFS를 통해 부서진 자리를 고려하지 않고 한칸씩 띄워만 앉을 수 있는 모든 배치를 구한다.
 
 가장 아래 행부터 DFS로 가장 위 행까지 올라가면서 비트 마스크 DP를 통해 최댓값을 저장한다.
 
 DFS의 매개변수로 이전 행의 배치를 넣어서 대각선 컨닝이 되는지 안되는지 검사해야 한다.
 
 굉장히 어려웠는데 DP는 구현이나 알고리즘 난이도보다, 문제이해자체가 어려운거같다.
      
 */

