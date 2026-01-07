import Foundation

// 필요없는데 나중에 필요할까바 남겨둔 at함수
//extension String {
//    func at(_ index: Int) -> Self {
//        return String(self[self.index(self.startIndex, offsetBy: index)])
//    }
//}

func solution_11(_ numbers: String) -> Int {

    let weights = [
        [1, 7, 6, 7, 5, 4, 5, 3, 2, 3],
        [7, 1, 2, 4, 2, 3, 5, 4, 5, 6],
        [6, 2, 1, 2, 3, 2, 3, 5, 4, 5],
        [7, 4, 2, 1, 5, 3, 2, 6, 5, 4],
        [5, 2, 3, 5, 1, 2, 4, 2, 3, 5],
        [4, 3, 2, 3, 2, 1, 2, 3, 2, 3],
        [5, 5, 3, 2, 4, 2, 1, 5, 3, 2],
        [3, 4, 5, 6, 2, 3, 5, 1, 2, 4],
        [2, 5, 4, 5, 3, 2, 3, 2, 1, 2],
        [3, 6, 5, 4, 5, 3, 2, 4, 2, 1],
    ]

    let numbersCount = numbers.count

    var dp = Array(
        repeating: Array(
            repeating: Array(repeating: Int.max, count: 10),
            count: 10
        ), count: numbersCount + 1
    )

    dp[0][4][6] = .zero
    //[number][left][right]

    numbers.enumerated().forEach { idx, v in
        let num = Int(String(v))!

        for i in 0..<10 {
            for j in 0..<10 {
                let prevValue = dp[idx][i][j]

                if i == j || prevValue == Int.max { continue }

                // 오른손으로 누른 경우
                if dp[idx + 1][num][j] > prevValue + weights[i][num] {
                    dp[idx + 1][num][j] = prevValue + weights[i][num]
                    // Int.max > 이전 가중치 prevValue + 오른손으로 새로운 번호를 눌렀을 때의 가중치 가 참인경우 값 업데이트
                }

                // 왼손으로 누른 경우
                if dp[idx + 1][i][num] > prevValue + weights[num][j] {
                    dp[idx + 1][i][num] = prevValue + weights[num][j]
                }
            }
        }
    }
    return dp[numbers.count].flatMap({ $0 }).min()!
}
