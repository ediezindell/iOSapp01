//
//  ViewController.swift
//  multipage
//
//  Created by 井上義章 on 20200416.
//  Copyright © 2020 井上義章. All rights reserved.
//

import UIKit

protocol EditViewControllerDelegate {
    func editDidFinished(title: String?, body: String?)
}

class EditViewController: UIViewController, UITextViewDelegate {

    var titleText = "title"
    var bodyText = "ここに内容を入力"
//    var delegate: EditViewControllerDelegate! = nil
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
//        UserDefaults.standard.set(memos, forKey: "MEMO")

        print("saved")
        // 移動？
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
        print("dismiss")

//        delegate.editDidFinished(title: newTitle, body: newBody)
//        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkCount(count: bodyText.count)
        bodyTextView.text = bodyText
        bodyTextView.delegate = self
    }

    func textViewDidChange(_ textView: UITextView) {
        checkCount(count: textView.text.count)
    }
    
    func checkCount(count: Int) {
        self.title = "\(titleText) (文字数: \(String(count)))"
    }

}

