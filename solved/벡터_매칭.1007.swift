import Foundation

struct Point1007: Hashable {
    var x: Int64
    var y: Int64

    init(_ p: [Int64]) {
        self.x = p[0]
        self.y = p[1]
    }

    static func - (lhs: Self, rhs: Self) -> Self {
        return Point1007([lhs.x - rhs.x, lhs.y - rhs.y])
    }
}

func solve_1007() {

    let tc = Int(readLine()!)!
    var points: [[Point1007]] = [[Point1007]](repeating: [], count: tc)

    for i in 0..<tc {
        let numOfPoints = Int(readLine()!)!
        for _ in 0..<numOfPoints {
            let input = readLine()!.components(separatedBy: " ").map { Int64($0)! }
            points[i].append(Point1007(input))
        }
    }

    func backtracking(_ array: [Point1007], _ endPointsSummation: Point1007, _ start: Int, _ ans: [Point1007], _ r: Int, _ dd: inout Double) {
        if ans.count == r {
            // 조합이 완성 되었을 때, endPointsSummation은 자동으로 끝점들을 모두 합한 값이된다.
            let startPointsSummation = ans.reduce(Point1007([0, 0])) { Point1007([$0.x + $1.x, $0.y + $1.y]) }
            let squareOfStartPointsSummation = Int64(pow(Double(startPointsSummation.x - endPointsSummation.x), 2))
            let squareOfEndPointsSummation = Int64(pow(Double(startPointsSummation.y - endPointsSummation.y), 2))
            let magnitude = sqrt(Double(squareOfStartPointsSummation + squareOfEndPointsSummation))
            dd = min(dd, magnitude)
        } else {
            for i in start..<array.count {
                var temp = ans
                temp.append(array[i])
                // endPointsSummation - array[i] -> 모든 점들을 합한 값에서 조합에 포합된 점(=시작점)을 빼준다.
                backtracking(array, endPointsSummation - array[i], i + 1, temp, r, &dd)
            }
        }
    }

    for p in points {
        var dd: Double = 300000.0
        // 그냥 처음 부터 모든 점들의 합을 구해서 넘겨줌.
        let endPointsSummation = p.reduce(Point1007([0, 0])) { Point1007([$0.x + $1.x, $0.y + $1.y]) }
        backtracking(p, endPointsSummation, 0, [], p.count / 2, &dd)
        print(dd)
    }
}

/*
 
 https://www.acmicpc.net/problem/1007
 2025.2.7
 
 2차원 좌표평면상의 N개의 점(X, Y)이 주어질 때, 두 점을 이어서 (N / 2)개의 벡터를 생성할 수 있다.
 
 생성된 모든 벡터를 합한 벡터의 크기를 최소화하는 문제이다.
 
 -100,000 <= X, Y <= 100,000
 
 2 <= N <= 20 (단, N은 짝수)
 
 아이디어
 
 a = (4, 7)
 b = (-4, 2)
 c = (-10, -8)
 d = (3, -9)
 
 위와같이 4개의 점이 주어졌다고 하자.

 벡터 ac와 bd를 만들어 합했을 때 벡터의 크기는 sqrt(725)이다.
 ac + bd = (-14, -15) + (7, -11) = (-7, -26) = sqrt(725)
 
 벡터 ad와 bc를 만들어 합했을 때 벡터의 크기는 sqrt(725)이다.
 ad + bc = (-1, -16) + (-6, -10) = (-7, -26) = sqrt(725)
 
 위 경우는 시작점이 a,b로 같고 끝점은 c로 끝나든 d로 끝나든 sqrt(725)로 크기가 같아진다.
 
 즉, 벡터의 시작이되는 점들의 집합이 같다면 끝점에 관계없이 벡터의 크기는 같아지므로 아래 식이 성립한다.
 
 { 벡터의 시작이되는 점들의 합 } - { 벡터의 끝이 되는 점들의 합 }
 = (a + b) - (c + d)
 = {(4, 7) + (-4, 2)} - {(-10, -8) + (3, -9)}
 = {(0, 9)} - {(-7, -17)}
 = (0 - (-7), 9 - (-17))
 = (7, 26)
 = sqrt(7^2 + 26^2)
 = sqrt(725)
 
 N이 20일때 절반의 점이 벡터의 시작이 되는 점이므로 20개중 10개를 뽑는 조합의 경우의 수(20C10 = 184,756)를 모두 탐색하면 된다.
 
 부호(벡터의 방향)가 달라질 수는 있지만 크기를 구할때 제곱하므로 상관없다.
 
 1. ca + db = (14, 15) + (-7, 11) = (7, 26) = sqrt(725)
 2. cb + da = (6, 10) + (1, 16) = (7, 26) = sqrt(725)
 3. (-7, -17) - (0, 9) = (-7 - 0, -17 - 9) = (-7, -26) = sqrt(725)
 
 1. ab + cd = (-8, -5) + (13, -1) = (5, -6) = sqrt(61)
 2. ad + cb = (-1, -16) + (6, 10) = (5, -6) = sqrt(61)
 3. (-6, -1) - (-1, -7) = (-6 - (-1), -1 - (-7)) = (-5, 6) = sqrt(61)
 
 DFS, 백트래킹을 사용해 조합을 구해주면서 벡터의 크기를 계산하고 최소값을 저장한다.
 
 처음엔 백트래킹으로 조합을 모두 구한 후, 다시한번 조합들을 순회하면서 { 벡터의 시작이되는 점들의 합 } - { 벡터의 끝이 되는 점들의 합 }를 계산해주면서 최소값을 구함 -> 시간초과.
 
 이후 조합을 구함과 동시에 { 벡터의 시작이되는 점들의 합 } - { 벡터의 끝이 되는 점들의 합 }를 계산함.
 즉 조합을 구하는 로직에 벡터의 합 크기 구하는 로직을 포함시킴 -> 시간초과.
 
 원래 로직에서 끝이되는 점들의 합을 { 전체 점들 - 조합에 포함된 점들(즉, 시작점들) }을 통해 구해서 전부 reduce로 합해서 구했는데,
 
 그냥 처음부터 N개의 모든 점들을 합한 값을 백트래킹 함수에 인자로 넣어주면서 조합에 포함된 점들이 생길때마다 해당 점을 빼주는 식으로 바꿈. -> 통과

 */
