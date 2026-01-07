import Foundation

let d = solution(12, [1, 5, 6, 10], [1, 2, 3, 4])
print(d)

while true {
    let number = readLine()!
    if number == "0" {
        break
    } else {
        if String(number.prefix(number.count / 2)) == String(number.suffix(number.count / 2).reversed()) {
            print("yes")
        } else {
            print("no")
        }
    }
}
