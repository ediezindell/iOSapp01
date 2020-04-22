//
//  ViewController.swift
//  multipage
//
//  Created by 井上義章 on 20200416.
//  Copyright © 2020 井上義章. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EditViewControllerDelegate {

    @IBOutlet weak var editField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var settingButton: UIBarButtonItem!
    @IBAction func tapEditButton(_ sender: UIButton) {
        let view = storyboard?.instantiateViewController(withIdentifier: "editViewController") as! EditViewController
        if editField.text! != "" {
            view.text = editField.text!
        }
        view.delegate = self
        present(view, animated: true, completion: nil)
    }
    
    func editDidFinished(modalText text: String?) {
        editField.text = text
    }
    override func viewDidLoad() {
        super.viewDidLoad()

//        editField.font = UIFont(name: settingFont, size: (editField.font?.pointSize)!)
//        editButton.titleLabel?.font = UIFont(name: settingFont, size: (editButton.titleLabel?.font.pointSize)!)!
   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        editField.text = appDelegate.Text
    }

    @IBAction func backFromEdit(segue: UIStoryboardSegue) {
    }
    @IBAction func backFromSettings(segue: UIStoryboardSegue) {
    }

}

