import Foundation

func solve_1034() {
    let fio = FileIO()
    var answer = 0
    let n = fio.readInt(), _ = fio.readInt()

    let table = (0..<n).map { _ in fio.readString().map { String($0) } }
    let k = fio.readInt()

    for row in table {
        var temp = table
        let zeros = row.enumerated().filter { $1 == "0" }.map { $0.offset }

        if zeros.count <= k && zeros.count % 2 == k % 2 {
            temp = temp.map { row in row.enumerated().map { zeros.contains($0) ? $1 == "1" ? "0" : "1": $1 } }
            answer = max(answer, temp.filter { $0.allSatisfy { $0 == "1" } }.count)
        }
    }
    print(answer)
}

/*
 https://www.acmicpc.net/problem/1034
 2025.2.19
 
 아이디어를 통한 완전 탐색
 
 왜 이 아이디어가 적용가능한지는 아직도 이해안감
 
 table의 row를 순회하면서 가능하다면 버튼을 눌러서 모두 1로 만든다.
 
 그렇게 만들어진 테이블의 모두 1인 row의 수를 센다.
 
 반복하면서 최대값을 찾으면 그게 정답.

 */


/*
5 1
0
1
0
1
0
1000
 2
 
14 3
001
101
001
000
111
001
101
111
110
000
111
010
110
001
6
 4
 
5 2
01
10
01
01
10
1
 3
 */
