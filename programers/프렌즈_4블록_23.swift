import Foundation

struct PPoint: Hashable {
    var r: Int
    var c: Int
}

func solution_23(_ m: Int, _ n: Int, _ board: [String]) -> Int {
    var result = Int.zero
    var gameBoard: [[String]] = board.map { $0.map { String($0) } }

    while true {
        var deleted: Set<PPoint> = []

        for r in 0...m - 2 {
            for c in 0...n - 2 {
                let set: Set<String> = [gameBoard[r][c], gameBoard[r + 1][c], gameBoard[r][c + 1], gameBoard[r + 1][c + 1]]
                if set.count == 1 && set.first! != "-" {
                    deleted.insert(PPoint(r: r, c: c))
                    deleted.insert(PPoint(r: r + 1, c: c))
                    deleted.insert(PPoint(r: r, c: c + 1))
                    deleted.insert(PPoint(r: r + 1, c: c + 1))
                }
            }
        }

        if deleted.isEmpty {
            break
        } else {
            result += deleted.count
        }

        var helll: [[String]] = []

        for c in 0...n - 1 {
            var temp: [String] = []
            for r in 0...m - 1 {
                if !deleted.contains(PPoint(r: m - 1 - r, c: c)) {
                    temp.append(gameBoard[m - 1 - r][c])
                }
            }
            while temp.count < m {
                temp.append("-")
            }
            helll.append(temp)
        }

        gameBoard = rotateLeft(helll)
    }
    return result
}

func rotateLeft(_ matrix: [[String]]) -> [[String]] {
    let n = matrix.count
    let m = matrix[0].count
    var rotated = Array(repeating: Array(repeating: "", count: n), count: m)

    for i in 0..<n {
        for j in 0..<m {
            rotated[m - j - 1][i] = matrix[i][j]
        }
    }

    return rotated
}

//"CCBDE"
//"AAADE"
//"AAABF"
//"CCBBF"
