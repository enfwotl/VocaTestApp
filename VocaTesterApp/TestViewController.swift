//
//  TestViewController.swift
//  VocaTesterApp
//
//  Created by SWUCOMPUTER on 13/04/2019.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    //view의 outlet
    @IBOutlet var labelKorean: UILabel!
    @IBOutlet var labelHint: UILabel!
    @IBOutlet var textAnswer: UITextField!
    @IBOutlet var viewNext: UIView!
    @IBOutlet var viewDone: UIView!
    
    //local 변수-1, 단어 시험(test)를 위한 변수들
    let voca: [String:String] = ["추측하다":"guess", "특별한,특유의":"particular",
                                 "임명하다,지정하다":"appoint", "기숙사":"domitory", "등록하다":"enroll",
                                 "수하물,소화물":"baggage", "둘러싸다,동봉하다":"enclose",
                                 "방학,휴가":"vacation", "관객,목격자":"spectator",
                                 "(거리,시간,관계가)먼":"distant"]
    var vocaShuffled: [(key: String, value: String)] = [] //같은 순서가 반복되는 걸 방지하기 위한 셔플
    var isDone: Bool = false
    var iIndex: Int = 0
    var iLevel: Int = 0 // 이전 화면에서 전달받은 난이도
    var sKorean: String = "" // 제시된 한국어
    var sAnswer: String = "" // 영어 정답
    
    //local 변수-2, 정답 화면을 위한 변수(베열)
    var AnswerList:[Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 단어 순서를 섞고 index 초기화
        if !isDone {
            vocaShuffled = voca.shuffled()
            iIndex = 0
            makeTest()
            viewNext.isHidden = isDone
            textAnswer.isEnabled = !isDone
        }
    }

    // 다음 버튼(다음 단어로 넘어가는 버튼, viewNext의 Next 버튼)
    @IBAction func buttonNextWord(_ sender: Any) {
        // 정답 여부를 체크해서 배열에 추가
        AnswerList.append((korean: sKorean, english: sAnswer, isCorrect: sAnswer.elementsEqual(textAnswer.text!)))
        iIndex += 1
        if iIndex < 9 {
            makeTest()
        } else if iIndex == 9 {
            makeTest()
            //마지막 단어이기 때문에 view 변경
            viewDone.isHidden = false
            viewNext.isHidden = true
        }
        textAnswer.text = ""
    }
    
    // 제시된 한국어 문제와 정답 변경
    func makeTest() {
        sKorean = vocaShuffled[iIndex].key
        sAnswer = vocaShuffled[iIndex].value
        
        labelKorean.text = sKorean
        if iLevel < 2 {
            makeHint()
        } else { // 난이도가 고급인 경우, 힌트를 주지 않음
            labelHint.text = ""
        }
    }
    
    // 힌트를 생성하는 함수, 길이가 길어져 따로 뺐음
    func makeHint() {
        let array = Array(sAnswer)
        var sHint:String = ""
        sHint.append(array[0])
        if iLevel == 0 { // 난이도 초급인 경우, 홀수번째는 글자를 보여주고 짝수번째는 공란(_)
            for i in 1...array.count-1 {
                if i % 2 == 0 { // 배열 index는 0부터이기 때문에 index가 짝수일때 글자 표시
                    sHint.append(array[i])
                } else {
                    sHint.append(" _")
                }
            }
        } else { // 난이도 중급인 경우, 앞자리 제외 모두 공란(_), 자릿수를 알려주지 않기 위해 띄어쓰기도 생략
            for _ in 1...array.count-1 {
                sHint.append("_")
            }
        }
        labelHint.text = sHint
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toResultView") {
            let destVC = segue.destination as! ResultViewController
            if !isDone { //결과 화면을 갔다가 다시 돌아오는 경우를 거르기 위해 체크
                //마지막 단어를 정답 리스트에 추가
                AnswerList.append((korean: sKorean, english: sAnswer,
                                   isCorrect: sAnswer.elementsEqual(textAnswer.text!)))
                //드디어 test가 끝났기에 isDone을 true로 전환, text editor도 제한
                isDone = true
                textAnswer.isEnabled = false
            }
            //결과 뷰에 정답 리스트 전달
            destVC.AnswerList = AnswerList
        }
    }
}
