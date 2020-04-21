//
//  ViewController.swift
//  multipageEditViewController
//
//  Created by 井上義章 on 20200416.
//  Copyright © 2020 井上義章. All rights reserved.
//

import UIKit

class SettingColorViewController: UIViewController {

    @IBOutlet weak var colorField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        colorField.text = settingFontColor
        print("ok")
    }

    
    @IBAction func submitColor(_ sender: Any) {
        let color = colorField.text
        settingFontColor = color!
        
        print("color: \(String(describing: color))")
        self.performSegue(withIdentifier: "toSettingTop", sender: self)
    }
        
}

