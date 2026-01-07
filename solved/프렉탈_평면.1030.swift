import Foundation

func solve_1030() {
    let io = FileIO()
    let s = io.readInt(), N = io.readInt(), K = io.readInt()
    let r1 = io.readInt(), r2 = io.readInt(), c1 = io.readInt(), c2 = io.readInt()
    var ans = ""
    let cs = (N - K) / 2
    let ce = N - cs

    if s == .zero {
        print("0")
        return
    }

    for r in r1...r2 {
        for c in c1...c2 {
            ans += dfs((r: r, c: c), s)
        }
        ans += "\n"
    }

    func dfs(_ coor: (r: Int, c: Int), _ depth: Int) -> String {

        let rowShare = Int(coor.r / (N^^(depth - 1)))
        let rowRemain = coor.r % (N^^(depth - 1))
        let columnShare = Int(coor.c / (N^^(depth - 1)))
        let columnRemain = coor.c % (N^^(depth - 1))

        if cs..<ce ~= rowShare && cs..<ce ~= columnShare { return "1" }

        if depth == 1 { return "0" }

        return dfs((r: rowRemain, c: columnRemain), depth - 1)
    }
    print(ans)
}

/*
 https://www.acmicpc.net/problem/1030
 프렉탈_평면.1030
 2025.3.27
 
 */

