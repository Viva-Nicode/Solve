import Foundation

func permutation<T>(_ elements: [T], _ k: Int) -> [[T]] {
    var result = [[T]]()
    var visited = [Bool](repeating: false, count: elements.count)

    func permut(_ now: [T]) {
        if now.count == k {
            result.append(now)
            return
        }

        for i in 0..<elements.count {
            if visited[i] == true { continue }
            visited[i] = true
            permut(now + [elements[i]])
            visited[i] = false
        }
    }
    permut([])
    return result
}

func solution_1(_ n: Int, _ weak: [Int], _ dist: [Int]) -> Int {

    let membersPerm = permutation(dist, dist.count)
    // 원형으로 된 외벽을 확장
    let linearWeak = weak + weak.map { n + $0 }
    var result = dist.count + 1

    for i in 0..<weak.count {
        // 외벽 점거 순서를 슬라이딩 윈도우 식으로 구해준다.
        let route = (i..<(i + weak.count)).map { linearWeak[$0] }

        for friends in membersPerm {
            var rc: Int? = .zero
            for ii in 0..<friends.count {
                // ii번째 인원이 고친 취약점보다 더 높은 취약점의 인덱스를 구한다.
                rc = route.firstIndex(where: { route[rc!] + friends[ii] < $0 })
                // 인덱스가 존재하지 않다면 즉 아직 안고친 더 높은 인덱스의 취약점이 존재하지 않는다면
                if rc == nil {
                    result = min(result, ii + 1)
                    break
                }
            }
        }
    }

    return result == dist.count + 1 ? -1 : result
}

/*
 https://school.programmers.co.kr/learn/courses/30/lessons/60062
 2025.1.30
 
 N이 작으므로 완전 탐색하되, 원형으로 된 외벽을 선형으로 확장하고, 투입되는 인원의 순열을 구해서 완전탐색하는 문제.
 
 떠올려야 했던 아이디어는 어떤 인원이 외벽을 고칠때, 시작점은 무조건 취약점에서 출발을 해야한다는 점.
 
 취약점이 [1, 5, 6, 10]처럼 주어졌다고 한다면,
 
 (1 -> 5 -> 6 -> 10)
 (5 -> 6 -> 10 -> 1)
 (6 -> 10 -> 1 -> 5)
 (10 -> 1 -> 5 -> 6)
 
 위와같이 인접한 취약점 순서만 고려해주면 되고 (1 -> 6 -> 5 -> 10)같은 경우는 고려해주지 않아도 된다는 점.
 
 원형 구조를 선형구조로 확장할 수 있고, 순열을 구할 수 있는가를 묻는 문제.
 
 사실 구현적 알고리즘보단 문제 이해와 아이디어가 더 중요했던 문제인듯.
 */
