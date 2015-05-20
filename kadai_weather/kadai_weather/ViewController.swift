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
        
        // アイコン初期表示
        DisplayWeatherIcon(0)
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
        
        DisplayWeatherIcon(row)
    }
    
    func DisplayWeatherIcon( row:Int ){
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
        
        // 画像の取得
        // 今日
        var tenki_today_string:String = json["forecasts"][0]["telop"].string!
        println(tenki_today_string)
        
        //var imagesize_width = (json["forecasts"][0]["image"]["width"].string!).toInt()
        //var imagesize_height = (json["forecasts"][0]["image"]["height"].string!).toInt()
        var imagesize_width = Int(50)
        var imagesize_height = Int(31)
        var pos_x = self.view.bounds.width/2 - CGFloat(imagesize_width/2)
        
        var image_url = NSURL(string:json["forecasts"][0]["image"]["url"].string!)
        var image_data = NSData(contentsOfURL:image_url!)
        var image = UIImage(data: image_data!)
        var image_view = UIImageView(image: image)
        image_view.tag = 1
        image_view.frame = CGRectMake(pos_x, CGFloat(300), CGFloat(imagesize_width), CGFloat(imagesize_height))
        
        for subview in self.view.subviews{
            if (1 == subview.tag){
                subview.removeFromSuperview()
            }
        }
        self.view.addSubview(image_view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

