import Foundation

func solve_1028() {
    let io = FileIO()
    var mine = [[Int]](repeating: [Int](repeating: 0, count: 1508), count: 1508)
    let r = io.readInt(), c = io.readInt()

    for i in 0..<r {
        let row = io.readString().map { Int(String($0))! }
        for j in 0..<row.count {
            mine[i][j] = row[j]
        }
    }

    var ld = [[Int]](repeating: [Int](repeating: 0, count: 808), count: 808)
    var rd = [[Int]](repeating: [Int](repeating: 0, count: 808), count: 808)
    var lu = [[Int]](repeating: [Int](repeating: 0, count: 808), count: 808)
    var ru = [[Int]](repeating: [Int](repeating: 0, count: 808), count: 808)

    for i in stride(from: r, through: 0, by: -1) {
        for j in 0...c {
            if mine[i][j] == 1 {
                ld[i][j] = (j == 0 ? 0 : ld[i + 1][j - 1]) + 1
                rd[i][j] = rd[i + 1][j + 1] + 1
            }
        }
    }

    for i in 0...r {
        for j in 0...c {
            if mine[i][j] == 1 {
                lu[i][j] = (j == 0 || i == 0 ? 0 : lu[i - 1][j - 1]) + 1
                ru[i][j] = (i == 0 ? 0 : ru[i - 1][j + 1]) + 1
            }
        }
    }

    for i in 0..<5 {
        print(ld[i][0..<5])
    }

    var ans = Int.zero

    for i in 0...r {
        for j in 0...c {
            if min(ld[i][j], rd[i][j]) >= 1 {
                for k in stride(from: min(ld[i][j], rd[i][j]), through: 1, by: -1) {
                    if mine[i + 2 * (k - 1)][j] >= 1, lu[i + 2 * (k - 1)][j] >= k, ru[i + 2 * (k - 1)][j] >= k {
                        ans = max(ans, k)
                        break
                    }
                }
            }

            if min(ru[i][j], rd[i][j]) >= 1 {
                for k in stride(from: min(ru[i][j], rd[i][j]), through: 1, by: -1) {
                    if mine[i][j + 2 * (k - 1)] >= 1, lu[i][j + 2 * (k - 1)] >= k, ld[i][j + 2 * (k - 1)] >= k {
                        ans = max(ans, k)
                        break
                    }
                }
            }
        }
    }
    print(ans)
}

/*
 https://www.acmicpc.net/problem/1028
 다이아몬드_광산.1028
 2025.3.2
 
 누적합 + DP를 이용한 문제.
 
 DP를 만들되, DP[i][j]의 값은 현재위치 (i, j)를 포함해서 왼쪽 아래 대각선의 1의 갯수가 된다.
 
 예를 들어 주어진 입력이 아래와 같다면,
 
 5 5
 01100
 01011
 11111
 01111
 11111
 
 ld는 아래와 같이 만들어진다.
 
 [0, 1, 3, 0, 0]
 [0, 2, 0, 4, 4]
 [1, 1, 3, 3, 3]
 [0, 2, 2, 2, 2]
 [1, 1, 1, 1, 1]
 
 입력의 (1, 3)을 포함해서 왼쪽아래 대각선 방향으로 1의 갯수는 4가 되고 ld[1][3] = 4이다.
 
 왼쪽 아래 처럼 오른쪽 아래, 왼쪽 위, 오른쪽 위도 만들어준다.
 
 이래 n^2으로 다시한번 입력을 반복하면서, 1이 발견되었다면, 해당 1이 다이아몬드의 위쪽 꼭짓점의 1이거나, 왼쪽 꼭짓점의 1이라고 가정했을 때,
 
 크기가 몇인 다이아가 만들어지는가를 ans = max(ans, k)를 통해 저장해주면 된다.
 
 위쪽 꼭짓점이라고 가정했을 때,
 
 ld[i][j], rd[i][j] 두 값중 더 작은 값이 해당 1이 위쪽 꼭짓점이었을 때 만들어지는 다이이몬드 크기의 최댓값이 된다.
 
 그다음, min(ld[i][j], rd[i][j])부터 1까지 반복해주면서 다이아몬드의 아랫쪽 꼭짓점이 1인지,
 
 1이 맞다면, 아래쪽 꼭짓점에서 lu, ru의 값이, min(ld[i][j], rd[i][j])(코드에서는 k)보다 같거나 큰지 검사해준다.
 
 왼쪽 꼭짓짓이라고 가정했을 때에도 방향만 바꿔서 이와같이 해준다.
 
 */

