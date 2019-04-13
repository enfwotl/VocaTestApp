//
//  ViewController.swift
//  VocaTesterApp
//
//  Created by SWUCOMPUTER on 13/04/2019.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //view의 outlet
    @IBOutlet var pickerLevel: UIPickerView!
    
    //local변수
    let levelArray: [String] = ["초급", "중급", "고급"] //난이도 picker를 위한 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //picker 관련 설정 함수들
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return levelArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return levelArray[row]
    }
    
    //선택한 난이도를 test view에 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTestView" {
            let destVC = segue.destination as! TestViewController
            let level: Int = pickerLevel.selectedRow(inComponent: 0)
            
            destVC.iLevel = level
            destVC.isDone = false
        }
    }

}

