//
//  ViewController.swift
//  multipage
//
//  Created by 井上義章 on 20200416.
//  Copyright © 2020 井上義章. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITextViewDelegate {

    var titleText = "title"
    var bodyText = "ここに内容を入力"
    var nowEditId = -1 // -1: 未選択

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    @IBOutlet weak var bodyTextView: UITextView!

    @IBAction func saveButton(_ sender: UIButton) {
        
        let newBody = bodyTextView.text!
        if nowEditId == -1 {
            let newTitle = titleText
            let newMemo: MemoObj! = MemoObj(title: newTitle, body: newBody)
            memos.append(newMemo)
        } else if memos[nowEditId].body != newBody {
            memos[nowEditId].updateBody(body: newBody)
        }
        // 保存
        let encodedMemo = try? NSKeyedArchiver.archivedData(withRootObject: memos, requiringSecureCoding: false)
        UserDefaults.standard.set(encodedMemo, forKey: "MEMO")
        UserDefaults.standard.synchronize()
        
        // 移動
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkCount(count: bodyText.count)
        bodyTextView.text = bodyText
        bodyTextView.textColor = UIColor.colorFromRGB(rgb: settingFontColor, alpha: 1)
        bodyTextView.font = UIFont(name: settingFont, size: CGFloat(settingFontSize))
        bodyTextView.delegate = self
    }

    func textViewDidChange(_ textView: UITextView) {
        checkCount(count: textView.text.count)
    }
    
    func checkCount(count: Int) {
        self.title = "\(titleText) (文字数: \(String(count)))"
    }

}

