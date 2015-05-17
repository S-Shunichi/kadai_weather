//
//  ViewController.swift
//  kadai_weather
//
//  Created by 坂口峻一 on 2015/05/17.
//  Copyright (c) 2015年 坂口峻一. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var m_LocationPicker : UIPickerView!
    private let m_PickerValue : NSArray = ["東京", "大阪", "福岡"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // プルダウンの設置
        m_LocationPicker = UIPickerView()
        m_LocationPicker.frame = CGRectMake(0, 0, self.view.bounds.width, 180)
        m_LocationPicker.delegate = self
        m_LocationPicker.dataSource = self
        self.view.addSubview(m_LocationPicker)
    }

    /*
    pickerに表示する列数を返すデータソースメソッド.
    (実装必須)
    */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*
    pickerに表示する行数を返すデータソースメソッド.
    (実装必須)
    */
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return m_PickerValue.count
    }
    
    /*
    pickerに表示する値を返すデリゲートメソッド.
    */
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return m_PickerValue[row] as! String
    }
    
    /*
    pickerが選択された際に呼ばれるデリゲートメソッド.
    */
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        println("row: \(row)")
        println("value: \(m_PickerValue[row])")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

