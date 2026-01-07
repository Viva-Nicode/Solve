import Foundation

final class FileIO {
    private let buffer: [UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(try! fileHandle.readToEnd()!) + [UInt8(0)]  // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

        return buffer[index]
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10
            || now == 32
        { now = read() }  // 공백과 줄바꿈 무시
        if now == 45 {
            isPositive.toggle()
            now = read()
        }  // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now - 48)
            now = read()
        }

        return sum * (isPositive ? 1 : -1)
    }

    @inline(__always) func readString() -> String {
        var now = read()

        while now == 10 || now == 32 { now = read() }  // 공백과 줄바꿈 무시

        let beginIndex = index - 1

        while now != 10,
            now != 32,
            now != 0
        { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index - 1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() }  // 공백과 줄바꿈 무시

        let beginIndex = index - 1

        while now != 10,
            now != 32,
            now != 0
        { now = read() }

        return Array(buffer[beginIndex..<(index - 1)])
    }
}

extension Array where Element == Int {

    func firstIntIndex(of: Int) -> Int? {
        if let stringIndex = self.firstIndex(of: of) {
            return self.distance(from: self.startIndex, to: stringIndex)
        }
        return nil
    }

    func firstIntIndex(where condition: (Int) -> Bool) -> Int? {
        if let idx = self.firstIndex(where: { condition($0) }) {
            return self.distance(from: self.startIndex, to: idx)
        }
        return nil
    }
}

extension String {

    subscript(_ index: Int) -> Self {
        Self(self[self.index(self.startIndex, offsetBy: index)])
    }

    subscript(_ range: ClosedRange<Int>) -> Self {
        let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
        return String(self[startIndex...endIndex])
    }

    func firstIntIndex(of: Character) -> Int? {
        if let stringIndex = self.firstIndex(of: of) {
            return self.distance(from: self.startIndex, to: stringIndex)
        } else {
            return nil
        }
    }

    func firstIntIndex(where condition: (Character) -> Bool) -> Int? {
        if let idx = self.firstIndex(where: { condition($0) }) {
            return self.distance(from: self.startIndex, to: idx)
        }
        return nil
    }
}

infix operator ^^ : MultiplicationPrecedence

func ^^ (base: Int, power: Int) -> Int {
    return Int(pow(Double(base), Double(power)))
}
