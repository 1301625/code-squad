import Foundation

enum Control : String {
    case l,r,L,R
}

struct PushWord {
    
    var word : String
    var count : Int
    var control : Control?
        
    mutating func leftPush(count : Int) {
        let index = count % word.count
        word = word[index..<word.count] + word[0..<index]
    }
    
    mutating func rightPush(count : Int) {
        let index = word.count - (count % word.count)
        word = word[index..<word.count] + word[0..<index]
    }
    
    mutating func countCheck() -> Bool {
        return count < 100 && count >= -100 ? true : false
    }
    
    mutating func minCountProcess() {
        if self.count < 0 {
            count = -count
            controlChange()
        }
    }
    
    mutating func controlChange() {
        if control != nil {
            control = control == .R || control == .r ? .L : .R
        }
    }
    
    mutating func process() {
        if !countCheck() { print("숫자 범위를 벗어났습니다")
            return }
        minCountProcess()
        switch control {
        case .L , .l :
            leftPush(count: count)
        case .R , .r :
            rightPush(count: count)
        default:
            print("방향을 잘못 입력했습니다")
        }
        print(word)
    }
}
