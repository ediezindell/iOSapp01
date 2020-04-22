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
//        let newMemo: MemoObj! = MemoObj(title: title!, body: body!)
//        memos.append(newMemo)
//        print("saved")
//        print(memos)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(memos.count)
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = indexPath.row
        let memo = memos[id]
        let title = memo.title
        let body = memo.body
        toEditPage(title: title, body: body, id: id)
        print("[\(indexPath.section)][\(indexPath.row)]番目の行が選択されました。")
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell;
        cell = tableView.dequeueReusableCell(withIdentifier: "memoListCell", for: indexPath)

        //各要素にはタグでアクセスする
        let titleLabel: UILabel = cell.viewWithTag(1)! as! UILabel
        titleLabel.font = UIFont(name: settingFont, size: CGFloat(settingFontSize))
        titleLabel.textColor = UIColor.colorFromRGB(rgb: settingFontColor, alpha: 1)
        titleLabel.text = memos[indexPath.row].title

        //各要素にはタグでアクセスする
        let createdLabel: UILabel = cell.viewWithTag(2)! as! UILabel
        let updatedLabel: UILabel = cell.viewWithTag(3)! as! UILabel
        createdLabel.text = memos[indexPath.row].created_at
        updatedLabel.text = memos[indexPath.row].updated_at
        createdLabel.font = UIFont(name: settingFont, size: 10.0)
        updatedLabel.font = UIFont(name: settingFont, size: 10.0)

        return cell
    }
    
    @IBOutlet weak var newTitleField: UITextField!
    @IBAction func addButton(_ sender: Any) {
        var newTitle = newTitleField.text!
        if newTitle == "" {
            newTitle = "無題"
        }

        toEditPage(title: newTitle, body: "ここに内容を入力します", id: -1)
    }
    func toEditPage(title: String, body: String, id: Int) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "editViewController") as! EditViewController
        nextViewController.titleText = title
        nextViewController.bodyText = body
        nextViewController.nowEditId = id
        //        nextViewController.delegate = self
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBOutlet weak var memoListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        memoListTable.frame = view.frame
        memoListTable.dataSource = self
        memoListTable.delegate = self
        memoListTable.tableFooterView = UIView(frame: .zero)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        memoListTable?.reloadData()
    }
    @IBAction func backFromEdit(segue: UIStoryboardSegue) {
        memoListTable?.reloadData()
    }
    @IBAction func backFromSettings(segue: UIStoryboardSegue) {
    }

}

