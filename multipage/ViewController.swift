//
//  ViewController.swift
//  multipage
//
//  Created by 井上義章 on 20200416.
//  Copyright © 2020 井上義章. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, EditViewControllerDelegate {

    func editDidFinished(title: String?, body: String?) {
        let newMemo: MemoObj! = MemoObj(title: title!, body: body!)
        memos.append(newMemo)
        print("saved")
        print(memos)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell;
        cell = tableView.dequeueReusableCell(withIdentifier: "memoListCell", for: indexPath)

        //各要素にはタグでアクセスする
        let settingLabel: UILabel = cell.viewWithTag(1)! as! UILabel
        settingLabel.font = UIFont(name: settingFont, size: CGFloat(settingFontSize))
        settingLabel.textColor = UIColor.colorFromRGB(rgb: settingFontColor, alpha: 1)
        settingLabel.text = memos[indexPath.row].title

        return cell
    }
    
    @IBOutlet weak var newTitleField: UITextField!
    @IBAction func addButton(_ sender: Any) {
        let newTitle = newTitleField.text!
        
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "editViewController") as! EditViewController
        if newTitle == "" {
            nextViewController.titleText = "無題"
        } else {
            nextViewController.titleText = newTitle
        }
//        nextViewController.delegate = self
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backFromEdit(segue: UIStoryboardSegue) {
    }
    @IBAction func backFromSettings(segue: UIStoryboardSegue) {
    }

}

