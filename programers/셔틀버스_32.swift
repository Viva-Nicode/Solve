import Foundation

extension String {
    var min: Int {
        Int(self.components(separatedBy: ":")[0])! * 60 + Int(self.components(separatedBy: ":")[1])!
    }
}

extension Int {
    var convertToTime: String {
        String(format: "%02d:%02d", self / 60, self % 60)
    }
}

func solution_32(_ n: Int, _ t: Int, _ m: Int, _ timetable: [String]) -> String {

    let times = timetable.map { $0.min }.sorted()
    var seat = m
    var bustime = 0
    var i = 0

    while true {
        if times[i] <= bustime * t + 540 {
            // 시간이 되면 탑승한다.
            // 자리 하나 감소
            seat -= 1
            // 다음승객 인덱스
            i += 1
        } else {
            // 시간이 안돼서 못탄다.
            if seat > 0 {
                // 근데 자리가 남는다.
                // 그러면 자리 초기화해주고 다음 버스 시간으로 바꿔준다.
                bustime += 1
                seat = m
            }
        }

        if seat == 0 {
            // 자리가 없다.
            if bustime + 1 == n {
                // 근데 요번 버스가 막차였다.
                break
            } else {
                // 막차가 아니면 자리 초기화 후 다음 버스 시간으로 바꿔준다.
                bustime += 1
                seat = m
            }
        }

        // 마지막 승객이면 break
        if i >= times.count { break }
    }

    // while 루프를 빠져나온후 자리가 하나 이상 있으면 막차시간에, 그렇지 않으면 제일 늦게온놈 보다 1분 빨리 온다.
    if seat > 0 {
        return ((n - 1) * t + 540).convertToTime
    } else {
        return (times[i - 1] - 1).convertToTime
    }
}

/*
 
 2025.1.25
 
 https://school.programmers.co.kr/learn/courses/30/lessons/17678#qna
 
 let ne = ((n - 1) * t + 540)
 
 ne는 내가 가장 늦을 수 있는 막차 시간.
 
 결국 막차가 만원이냐 아니냐를 알아내야 함.
 
 막차가 만원이 아니라면 ne시간이 오면됨.
 
 막차가 만원이라면 막차를 타는 인원중에 가장 늦는 인원보다 1분 빨리 와야함.
 
 그럼 전차시간 + 1분 ~ 막차 사이, 에를 들어 차가 총 2대이고 1시간 간격으로 온다고 가정하면

 (09:01 ~ 10:00)에 온놈들의 수를 세면 되지 않느냐하는데

 전차에 탈수있는 시간에 온놈도 전차가 만원이면 다음차를 타야하는 경우가 있음. [00:01, 00:01, 00:01, 00:01...] 같은 경우

 그래서 막차가 만원이냐 아니냐를 알려면 이전 버스에서 얼마나 태웠냐를 알아야함.
 
 결국 정렬하고 처음부터 순회해주어야 함. 단순구현 문제였다.
 
 */
