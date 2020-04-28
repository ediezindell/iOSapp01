//
//  ViewController.swift
//  multipageEditViewController
//
//  Created by 井上義章 on 20200416.
//  Copyright © 2020 井上義章. All rights reserved.
//

import UIKit

class SettingColorViewController: UIViewController {

    var dispRGBText = "";
    @IBOutlet weak var colorField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        dispRGBText = settingFontColor
        setSlider()
        colorField.text = dispRGBText
        colorDispLabel.text = ""
        print("ok")
    }

    @IBOutlet weak var colorDispLabel: UILabel!
    @IBOutlet weak var RSlider: UISlider!
    @IBOutlet weak var GSlider: UISlider!
    @IBOutlet weak var BSlider: UISlider!
    func setSlider() {
        let c = UIColor.convertToRGB(UIColor(code: settingFontColor))
        RSlider.setValue(Float(c.red) * 255, animated: false)
        GSlider.setValue(Float(c.green) * 255, animated: false)
        BSlider.setValue(Float(c.blue) * 255, animated: false)
    }
    func reDisp() {
        let R = Int(lroundf(RSlider.value))
        let G = Int(lroundf(GSlider.value))
        let B = Int(lroundf(BSlider.value))
        let Rhex = (NSString(format: "%02X", R) as String)
        let Ghex = (NSString(format: "%02X", G) as String)
        let Bhex = (NSString(format: "%02X", B) as String)
        dispRGBText = "#\(Rhex)\(Ghex)\(Bhex)"
        colorField.text = dispRGBText
        colorDispLabel.backgroundColor = UIColor(code: dispRGBText)
    }
    
    @IBAction func redSlider(_ sender: UISlider) {
        reDisp()
    }
    @IBAction func greenSlider(_ sender: UISlider) {
        reDisp()
    }
    @IBAction func blueSlider(_ sender: UISlider) {
        reDisp()
    }
    @IBAction func submitColor(_ sender: UIButton) {
        let color = colorField.text
        let test = UIColor(code: settingFontColor)
        settingFontColor = color!
        
//        print("color: \(String(describing: color))")
        self.performSegue(withIdentifier: "toSettingTop", sender: self)
    }
        
}

