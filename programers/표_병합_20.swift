import Foundation

struct Cell {
    var r: Int
    var c: Int
    var keyword: String = ""
}

typealias Point = (r: Int, c: Int)

func solution_20(_ commands: [String]) -> [String] {
    var result: [String] = []
    var table: [[Cell]] = (0..<50).map { i in (0..<50).map { ii in Cell(r: i, c: ii) } }

    for command in commands {
        let parsed = command.components(separatedBy: " ")
        switch parsed[0] {
        case "UPDATE":
            if parsed.count == 4 {
                let currentCell = table[Int(parsed[1])! - 1][Int(parsed[2])! - 1]
                var nextCell: Point = (r: currentCell.r, c: currentCell.c)
                table[Int(parsed[1])! - 1][Int(parsed[2])! - 1].keyword = parsed[3]
                while !(Int(parsed[1])! - 1 == nextCell.r && Int(parsed[2])! - 1 == nextCell.c) {
                    table[nextCell.r][nextCell.c].keyword = parsed[3]
                    nextCell = (r: table[nextCell.r][nextCell.c].r, c: table[nextCell.r][nextCell.c].c)
                }
            } else {
                var targetCells: [Point] = []
                for (i, cells) in table.enumerated() {
                    for (ii, cell) in cells.enumerated() {
                        if cell.keyword == parsed[1] {
                            targetCells.append((r: i, c: ii))
                        }
                    }
                }

                while !targetCells.isEmpty {
                    let currentCell: Point = targetCells.removeFirst()
                    var nextCell: Point = (r: table[currentCell.r][currentCell.c].r, c: table[currentCell.r][currentCell.c].c)
                    table[currentCell.r][currentCell.c].keyword = parsed[2]
                    while !(currentCell.r == nextCell.r && currentCell.c == nextCell.c) {
                        table[nextCell.r][nextCell.c].keyword = parsed[2]
                        nextCell = (r: table[nextCell.r][nextCell.c].r, c: table[nextCell.r][nextCell.c].c)
                        if let idx = targetCells.firstIndex(where: { $0.r == nextCell.r && $0.c == nextCell.c }) {
                            targetCells.remove(at: idx)
                        }
                    }
                }
            }

        case "MERGE":
            let cell_1: Point = (r: Int(parsed[1])! - 1, c: Int(parsed[2])! - 1)
            let cell_1HadPoint: Point = (r: table[cell_1.r][cell_1.c].r, c: table[cell_1.r][cell_1.c].c)
            let cell_2: Point = (r: Int(parsed[3])! - 1, c: Int(parsed[4])! - 1)
            let cell_2HadPoint: Point = (r: table[cell_2.r][cell_2.c].r, c: table[cell_2.r][cell_2.c].c)

            var isNotSameSet = true

            var nextCellForSame: Point = (r: table[cell_1.r][cell_1.c].r, c: table[cell_1.r][cell_1.c].c)

            while !(cell_1.r == nextCellForSame.r && cell_1.c == nextCellForSame.c) {
                if nextCellForSame.r == cell_2.r && nextCellForSame.c == cell_2.c {
                    isNotSameSet = false
                    break
                } else {
                    nextCellForSame = (r: table[nextCellForSame.r][nextCellForSame.c].r, c: table[nextCellForSame.r][nextCellForSame.c].c)
                }
            }

            if !(cell_1.r == cell_2.r && cell_1.c == cell_2.c) && isNotSameSet {
                table[cell_1.r][cell_1.c].r = cell_2HadPoint.r
                table[cell_1.r][cell_1.c].c = cell_2HadPoint.c

                table[cell_2.r][cell_2.c].r = cell_1HadPoint.r
                table[cell_2.r][cell_2.c].c = cell_1HadPoint.c

                let newKeyword = table[cell_1.r][cell_1.c].keyword.isEmpty ? table[cell_2.r][cell_2.c].keyword : table[cell_1.r][cell_1.c].keyword
                table[cell_1.r][cell_1.c].keyword = newKeyword

                if !newKeyword.isEmpty {
                    var nextCell: Point = (r: table[cell_1.r][cell_1.c].r, c: table[cell_1.r][cell_1.c].c)
                    while !(cell_1.r == nextCell.r && cell_1.c == nextCell.c) {
                        table[nextCell.r][nextCell.c].keyword = newKeyword
                        nextCell = (r: table[nextCell.r][nextCell.c].r, c: table[nextCell.r][nextCell.c].c)
                    }
                }
            }

        case "UNMERGE":
            print(command)
            let currentCell: Point = (r: Int(parsed[1])! - 1, c: Int(parsed[2])! - 1)
            var nextCell: Point = (r: table[currentCell.r][currentCell.c].r, c: table[currentCell.r][currentCell.c].c)
            table[currentCell.r][currentCell.c].r = currentCell.r
            table[currentCell.r][currentCell.c].c = currentCell.c

            while !(currentCell.r == nextCell.r && currentCell.c == nextCell.c) {
                table[nextCell.r][nextCell.c].keyword = ""
                let r = nextCell.r
                let c = nextCell.c
                nextCell = (r: table[r][c].r, c: table[r][c].c)
                table[r][c].r = r
                table[r][c].c = c
            }

        case "PRINT":
            let keyword = table[Int(parsed[1])! - 1][Int(parsed[2])! - 1].keyword
            result.append(keyword.isEmpty ? "EMPTY" : keyword)

        default:
            break
        }
    }

    return result
}

//solution(["UPDATE 1 1 menu", "UPDATE 1 2 category", "UPDATE 2 1 bibimbap", "UPDATE 2 2 korean", "UPDATE 2 3 rice", "UPDATE 3 1 ramyeon", "UPDATE 3 2 korean", "UPDATE 3 3 noodle", "UPDATE 3 4 instant", "UPDATE 4 1 pasta", "UPDATE 4 2 italian", "UPDATE 4 3 noodle", "MERGE 1 2 1 3", "MERGE 1 3 1 4", "UPDATE korean hansik", "UPDATE 1 3 group", "UNMERGE 1 4", "PRINT 1 3", "PRINT 1 4"])

//solution(["UPDATE 1 1 a", "UPDATE 1 2 b", "UPDATE 2 1 c", "UPDATE 2 2 d", "MERGE 1 1 1 2", "MERGE 2 2 2 1", "MERGE 2 1 1 1", "PRINT 1 1", "UNMERGE 2 2", "PRINT 1 1"])

//solution(["UPDATE 1 1 A", "UPDATE 2 2 B", "UPDATE 3 3 C", "UPDATE 4 4 D", "MERGE 1 1 2 2", "MERGE 3 3 4 4", "MERGE 1 1 3 3", "UNMERGE 1 1", "PRINT 1 1", "PRINT 2 2", "PRINT 3 3", "PRINT 4 4"])
