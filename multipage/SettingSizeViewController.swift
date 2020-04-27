//
//  ViewController.swift
//  multipageEditViewController
//
//  Created by 井上義章 on 20200416.
//  Copyright © 2020 井上義章. All rights reserved.
//

import UIKit

class SettingSizeViewController: UIViewController {

    private func reDisp() {
        // スライダー
        sizeSlider.setValue(Float(settingFontSize), animated: false)
        // フォントサイズ
        nowFontSizeLabel.text = "\(settingFontSize)px"
        // プレビュー
        sizePreview.font = UIFont(name: settingFont, size: CGFloat(settingFontSize))
        sizePreview.textColor = UIColor(code: settingFontColor)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reDisp()
        print("ok")
    }
    
    @IBOutlet weak var nowFontSizeLabel: UILabel!
    @IBOutlet weak var sizePreview: UITextView!
    @IBOutlet weak var sizeSlider: UISlider!
    
    @IBAction func sizeSlider(_ sender: UISlider) {
        let size = Int(lroundf(sender.value))
        print("size: \(String(describing: size))")
        settingFontSize = size
        reDisp()
    }
        
}

