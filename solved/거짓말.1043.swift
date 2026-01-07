import Foundation

func solve_1043() {
    let fio = FileIO()
    let _ = fio.readInt(), partyCount = fio.readInt()
    let trueLoverCount = fio.readInt()

    var answer = partyCount

    var trueLovers: Set<Int> = []
    var 호구들: [Set<Int>] = []

    for _ in 0..<trueLoverCount {
        trueLovers.insert(fio.readInt())
    }

    for _ in 0..<partyCount {
        let participantCount = fio.readInt()
        var participants: Set<Int> = []

        for _ in 0..<participantCount { participants.insert(fio.readInt()) }

        if !trueLovers.intersection(participants).isEmpty {
            answer -= 1
            trueLovers = trueLovers.union(participants)
        } else {
            호구들.append(participants)
        }
    }

    while true {
        var dd = true
        for (i, 호구) in 호구들.enumerated() {
            if !trueLovers.intersection(호구).isEmpty {
                answer -= 1
                trueLovers = trueLovers.union(호구)
                호구들.remove(at: i)
                dd = false
                break
            }
        }

        if dd { break }

    }

    print(answer)
}

/*
 https://www.acmicpc.net/problem/1043
 
 2025.2.19
 
 아야츠노 유니온 파인드 문제.
 
 그냥 집합으로 해결
 
 */
