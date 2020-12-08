//
//  PushWord.swift
//  codesquad
//
//  Created by HOONHA CHOI on 2020/12/07.
//

import Foundation

enum Control : String {
    case l
    case r
    case L
    case R
}


struct PushWord {
    
    var word : String
    var count : Int
    var control : Control?
        
    mutating func leftPush(count : Int) {
        let index = count % word.count
        wordMove(index: index)
    }
    mutating func rightPush(count : Int) {
        let index = word.count - (count % word.count)
        wordMove(index: index)
    }
    
    mutating func wordMove(index : Int) {
        self.word = word[index..<word.count] + word[0..<index]
    }
    
    mutating func countCheck() -> Bool {
        return self.count < 100 && self.count >= -100 ? true : false
    }
    
    mutating func minCountProcess() {
        if self.count < 0 {
            countAbsChange()
            controlChange()
        }
    }
    
    mutating func countAbsChange() {
        self.count = -(self.count)
    }
    
    mutating func controlChange() {
        if self.control != nil {
            self.control = self.control == .R || self.control == .r ? .L : .R
        }
    }
    
    mutating func process() {
        
        if !countCheck() {
            print("숫자 범위를 벗어났습니다")
            return }
        
        minCountProcess()
        
        switch control {
        case .L , .l :
            leftPush(count: count)
            printWord()
        case .R , .r :
            rightPush(count: count)
            printWord()
        default:
            print("방향을 잘못 입력했습니다")
        }
    }
    
    func printWord() {
        print(self.word)
    }
    
}
