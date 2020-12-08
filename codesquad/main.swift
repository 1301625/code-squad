//
//  main.swift
//  codesquad
//
//  Created by HOONHA CHOI on 2020/12/07.
//

import Foundation


while true {
    print()
    print("=============================")
    print("선택해주세요")
    print("1. 단어 밀어내기")
    print("=============================")
    print()
    switch Int(readLine()!) ?? 0 {
    case 1:
        print("1단계: 단어 밀어내기")
        let input = readLine()!.components(separatedBy: " ")
        var pushword = PushWord(word: input[0],
                                count: Int(input[1]) ?? 0 ,
                                control: Control(rawValue: input[2]))
        pushword.process()
    case 9 :
        print("종료")
        exit(0)
    default:
        print("숫자만 입력해주세요")
    }
}
