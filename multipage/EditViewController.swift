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
        let newTitle = titleText
        let newBody = bodyTextView.text!
        let newMemo: MemoObj! = MemoObj(title: newTitle, body: newBody)
        if nowEditId == -1 {
            memos.append(newMemo)
        } else {
            memos[nowEditId] = newMemo
        }
        print("saved")
        // 移動？
        self.dismiss(animated: true, completion: nil)
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

