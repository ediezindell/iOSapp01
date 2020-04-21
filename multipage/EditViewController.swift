//
//  ViewController.swift
//  multipage
//
//  Created by 井上義章 on 20200416.
//  Copyright © 2020 井上義章. All rights reserved.
//

import UIKit

protocol EditViewControllerDelegate {
    func editDidFinished(modalText: String?)
}

class EditViewController: UIViewController {

    var text = "めも"
    var delegate: EditViewControllerDelegate! = nil
    @IBOutlet weak var editText: UITextField!
    @IBAction func tapButton(_ sender: UIButton) {
        delegate.editDidFinished(modalText: editText.text)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editText.text = text
    }

}

