import Foundation

func solve_2375() {

    let io = FileIO()
    let n = io.readInt()
    var list: [(x: Int, y: Int)] = []

    for _ in 0..<n {
        let x = io.readInt(), y = io.readInt(), p = io.readInt()
        list.append(contentsOf: (0..<p).map { _ in (x: x, y: y) })
    }

    let xs = list.map { $0.x }.sorted(by: { $0 < $1 })
    let ys = list.map { $0.y }.sorted(by: { $0 < $1 })
    let cnt = ys.count + (ys.count % 2 != 0 ? 1 : 0)

    print(xs[cnt / 2 - 1], ys[cnt / 2 - 1])
}

/*
 https://www.acmicpc.net/problem/2375
 농구_골대_세우기.2375
 2025.3.5
 
 */

