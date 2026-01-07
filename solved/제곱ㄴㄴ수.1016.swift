import Foundation

func solve_1016() {
    let fio = FileIO()
    let min = Int64(fio.readString())!, max = Int64(fio.readString())!
    let range = max - min + 1

    var l = [Bool](repeating: false, count: Int(range))
    var i: Int64 = 2
    var ans: Int64 = range

    while i * i <= max {
        var sNum: Int64 = min / (i * i)
        if min % (i * i) != 0 { sNum += 1 }

        while sNum * (i * i) <= max {
            let ii = Int(sNum * (i * i) - min)
            if !l[ii] {
                l[ii] = true
                ans -= 1
            }
            sNum += 1
        }
        i += 1
    }
    print(ans)
}

/*
 https://www.acmicpc.net/problem/1016
 문제를 보고 바로 뭔가 수학적 지식(정수론같은)을 이용하는 문제라는 느낌이 와서 20분만에 정답을 보길 잘한 문제.
 
 에라토스테네스의 체를 알아야 풀리는 문제라고한다.
 2025.2.17
 
 ㅈㅈ
 
 */
