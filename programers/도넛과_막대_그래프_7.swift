import Foundation

func solution_7(_ edges: [[Int]]) -> [Int] {

    let o = Set(edges.reduce(into: [:]) { $0[$1[0], default: 0] += 1 }.filter { $1 >= 2 }.keys)
    let i = edges.reduce(into: [:]) { $0[$1[1], default: 0] += 1 }
    let ins = Set(i.filter { $1 >= 2 }.keys)
    let center = o.subtracting(ins).map { $0 }.first!
    let eight = o.intersection(ins).count
    var stick_candidates = [Int]()

    var stick = Set(edges.filter { $0[0] != center ? true : stick_candidates.append($0[1]) != () }
            .map { $0[0] }).subtracting(Set(edges.map { $0[1] })).count

    stick += stick_candidates.filter { i[$0]! == 1 && !o.contains($0) }.count

    return [center, stick_candidates.count - (stick + eight), stick, eight]
}

/*
 
 2025 1 24
 
 https://school.programmers.co.kr/learn/courses/30/lessons/258711
 
 중앙 정점은 들어오는 간선이 0이고 나가는 간선이 2 이상인 정점이다.
 
 존재하는 모든 그래프의 수는 중앙 정점에서 나가는 간선의 수와 같다.
 
 팔자형 그래프의 수는 들어오는 간선이 2개이상 나가는 간선이 2개이상인 정점의 갯수와 같다.
 
 막대형 그래프의 수는 들어오는 간선의 수가 하나이고 나가는 간선은 0개인 정점의 수와 같다.
 
 도넛형 그래프의 수는 존재하는 모든 그래프의 수 - ( 팔자형 그래프의 수 + 막대형 그래프의 수) 가 된다.
 
 막대형 그래프의 갯수를 구할 때는 중앙 정점과 이어진 간선은 제외시켜서 고려하지 않는다.
 
 왜냐하면 중앙 점점과 이어진 간선까지 포함하면 입출력 예 #1 에서 막대가 2개 있게된다.
 
 들어오는 간선은 있는데 나가는 간선이 없는 경우가 [2,3], [4,3]으로 두개가 있다고 계산되기 때문.
 
 따라서 중앙 정점과 이어진 간선을 제외하고 계산하면 온전히 그래프들만 탐색할 수 있게 되는데 이러면 입출력 예 #2에서 막대가 하나도 없다고 나온다.
 
 [4,2]를 제외시켜버리면 2번 정점 하나있는 막대형 그래프는 고립되어 버린다.
 
 따라서 중앙 점점에서 들어오는 간선이 있는 정점들 2같은거를 저장 해놓고 나중에 i[$0]! == 1 && !o.contains($0) 를 만족하는 갯수 세서 막대형 그래프수에 더해준다.
 
 위 조건문은 2가 들어오는 간선은 하나인데 2에서 나가는 간선은 하나도 없는경우 참이다. 즉 고립된 막대형 그래프의 수를 세는 것이 된다.
 
 */
