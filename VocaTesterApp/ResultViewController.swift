//
//  ResultViewController.swift
//  VocaTesterApp
//
//  Created by SWUCOMPUTER on 14/04/2019.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    //view의 outlet
    @IBOutlet var labelAnswerList: UILabel!
    
    //local변수
    var AnswerList:[Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //단어 테스트의 정답 부분(영어)을 색을 다르게 보여주기 위한 코드들
        let attributedResult: NSMutableAttributedString = NSMutableAttributedString()
        
        //정답 레이블에 추가하기 위한 반복문
        for i in 0...AnswerList.count-1 {
            let result:String = String(i+1) + ". " + AnswerList[i].korean + "\t" + AnswerList[i].english + "\n"
            let attributedString = NSMutableAttributedString(string: result)
            if !AnswerList[i].isCorrect {
                //오답은 빨간색
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: (result as NSString).range(of:AnswerList[i].english))
            } else {
                //정답은 파란색
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: (result as NSString).range(of:AnswerList[i].english))
            }
            attributedResult.append(attributedString)
        }
        labelAnswerList.attributedText = attributedResult
    }

}
