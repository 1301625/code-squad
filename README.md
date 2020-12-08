# 2021 마스터즈 코스 1차 테스트

## 1단계: 단어 밀어내기 구현하기

####  구조

1. 메인.swift 에서  단어 , 정수 , L or R 을 입력 받고 구조체인 `PushWord` 에  입력한 값을 지정
2. `PushWord` 의 메서드인 `process()` 함수를 호출하고 먼저 `countCheck()`  메서드를 통해 정수값이 범위에 속해 있는지 확인 후 `false` 라면   return
3. `minCountProcess()` 메서드에서 음수라면 `count`  양수로 변경 ,  `controlChange()`  L 이라면 -> R ,  R 이라면 -> L  로 `control`  값을 변경
4. 현재 `control`  값을 통해 `leftPush`   또는 `rightPush`  메서드 호출  후 결과물 출력

#### 코드

- 구조체 정의

```swift
enum Control : String {
    case l,r,L,R
}

struct PushWord {
    
    var word : String
    var count : Int
    var control : control?
}
```

열거형을 통해 좌,우의 고유값 작성



- 정수 유효성 검사 , 음수의 경우 처리

```swift
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
    }
```

1. 먼저 숫자 범위 값 체크 후 Bool 값 반환

2. 음수라면 `minCountProcess` 를 통해 count 양수로 변경 및 control값도 변경



- 단어 이동

```swift
    mutating func leftPush(count : Int) {
        let index = count % word.count
        word = word[index..<word.count] + word[0..<index]
    }
    
    mutating func rightPush(count : Int) {
        let index = word.count - (count % word.count)
        word = word[index..<word.count] + word[0..<index]
    }

    mutating func process() {
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


extension String {
    subscript( int : Range<Int>) -> String {
        return String(self[index(startIndex, offsetBy: int.lowerBound)..<index(startIndex, offsetBy : int.upperBound)])
    }
}
```

switch문 통해 control 값에 따라 `leftPush` or `rightPush`  호출

`count값이` 길이가 `word` 의 글자 수 보다 많아도 반복적으로 움직인다는것을 알 수 있다,  % 연산자를 사용하여 나머지 값을 만 이동해도 같다는 것을 알 수 있어 %를 이용하여 움직일 값을 구하였다

extension string을 사용하였다 

이유는 String에서는  Array 에서 사용 가능한  `..<` subscript가 없으므로  String 값이 내가 원하는 만큼 출력할 수 있도록 subscript 를 구현했습니다.

