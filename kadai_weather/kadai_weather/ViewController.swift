//
//  ViewController.swift
//  kadai_weather
//
//  Created by 坂口峻一 on 2015/05/17.
//  Copyright (c) 2015年 坂口峻一. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // PickerView用のリストデータ
    private var m_LocationPicker : UIPickerView!
    private let m_PickerValue : NSArray = ["東京", "大阪", "福岡"]
    
    // JSON用のURL
    let TOKYO_URL = NSURL(string:"http://weather.livedoor.com/forecast/webservice/json/v1?city=130010")
    let OSAKA_URL = NSURL(string:"http://weather.livedoor.com/forecast/webservice/json/v1?city=270000")
    let FUKUOKA_URL = NSURL(string:"http://weather.livedoor.com/forecast/webservice/json/v1?city=400010")
    
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
        
        // JSONで天気データを取得
        var json_url : NSURL = NSURL(string: "")!
        switch row{
        case 0: // tokyo
            json_url = TOKYO_URL!
            break
        case 1: // osaka
            json_url = OSAKA_URL!
            break
        //case 2:
        default: // fukuoka
            json_url = FUKUOKA_URL!
            break
            
        }
        println(json_url)
        var json_data = NSData(contentsOfURL: json_url)
        let json = JSON(data:json_data!)
        
        var tenki_string:String = json["forecasts"]["telop"].string!
        println(tenki_string)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

