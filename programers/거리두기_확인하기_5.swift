import Foundation

func solution_5(_ places: [[String]]) -> [Int] {
    var result: [Int] = [1, 1, 1, 1, 1]

    let dr: [Int] = [0, -1, 0, 1]
    let dc: [Int] = [1, 0, -1, 0]

    let ddr: [Int] = [0, -2, 0, 2]
    let ddc: [Int] = [2, 0, -2, 0]

    let diagonalX: [Int] = [1, 1, -1, -1]
    let diagonalY: [Int] = [-1, 1, -1, 1]

    let wtf: [[Int]] = [[2, 3], [0, 3], [1, 2], [0, 1]]

    for (pidx, place) in places.enumerated() {

        var wr: [[String]] = Array(repeating: Array(repeating: "W", count: 9), count: 9)

        for (r, rv) in place.enumerated() {
            for (c, cv) in rv.enumerated() {
                wr[r + 2][c + 2] = String(cv)
            }
        }

        loop: for r in 2...6 {
            for c in 2...6 {
                if wr[r][c] == "P" {
                    print("\(r)\(c)")
                    for i in 0...3 {
                        if wr[r + dr[i]][c + dc[i]] == "P" {
                            result[pidx] = 0
                            break loop
                        }

                        if wr[r + ddr[i]][c + ddc[i]] == "P" && wr[r + dr[i]][c + dc[i]] != "X" {
                            result[pidx] = 0
                            break loop
                        }

                        if wr[r + diagonalX[i]][c + diagonalY[i]] == "P" &&
                            (wr[r + dr[wtf[i][0]]][c + dc[wtf[i][0]]] != "X" || wr[r + dr[wtf[i][1]]][c + dc[wtf[i][1]]] != "X") {
                            result[pidx] = 0
                            break loop
                        }
                    }
                }
            }
        }
    }
    return result
}
