//
//  ViewController.swift
//  multipage
//
//  Created by 井上義章 on 20200416.
//  Copyright © 2020 井上義章. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

//        // シェアのアクションを設定する
//        let shareAction = UIContextualAction(style: .normal  , title: "share") {
//            (ctxAction, view, completionHandler) in
//             print("シェアを実行する")
//            completionHandler(true)
//        }
//        // シェアボタンのデザインを設定する
//        let shareImage = UIImage(systemName: "square.and.arrow.up")?.withTintColor(UIColor.white, renderingMode: .alwaysTemplate)
//        shareAction.image = shareImage
//        shareAction.backgroundColor = UIColor(red: 0/255, green: 125/255, blue: 255/255, alpha: 1)

        // 削除のアクションを設定する
        let deleteAction = UIContextualAction(style: .destructive, title:"delete") {
            (ctxAction, view, completionHandler) in
            memos.remove(at: indexPath.row)
            self.memoListTable.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
            // 削除セーブ
            let encodedMemo = try? NSKeyedArchiver.archivedData(withRootObject: memos, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedMemo, forKey: "MEMO")
            UserDefaults.standard.synchronize()
        }
        // 削除ボタンのデザインを設定する
        let trashImage = UIImage(systemName: "trash.fill")?.withTintColor(UIColor.white , renderingMode: .alwaysTemplate)
        deleteAction.image = trashImage
        deleteAction.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)

        // スワイプでの削除を無効化して設定する
        let swipeAction = UISwipeActionsConfiguration(actions:[deleteAction])
        swipeAction.performsFirstActionWithFullSwipe = false
       
        return swipeAction

    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            memos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(memos.count)
        return memos.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !memoListTable.isEditing {
            let id = indexPath.row
            let memo = memos[id]
            let title = memo.title
            let body = memo.body
            toEditPage(title: title, body: body, id: id)
            print("[\(indexPath.section)][\(indexPath.row)]番目の行が選択されました。")
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            memos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
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
        createNewMemo()
    }
    //
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        createNewMemo()
        return true
    }
    func createNewMemo() {
        var newTitle = newTitleField.text!
        if newTitle == "" {
            newTitle = "無題"
        }
        newTitleField.text = ""
        toEditPage(title: newTitle, body: "ここに内容を入力します", id: -1)
    }
    func toEditPage(title: String, body: String, id: Int) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "editViewController") as! EditViewController
        nextViewController.titleText = title
        nextViewController.bodyText  = body
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
        memoListTable.allowsMultipleSelectionDuringEditing = true
        navigationItem.rightBarButtonItem = editButtonItem
        newTitleField.delegate = self
        hideKeyboardWhenTappedAround()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        memoListTable?.reloadData()
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        memoListTable.isEditing = editing

        print(editing)
    }
    @IBAction func backFromEdit(segue: UIStoryboardSegue) {
        memoListTable?.reloadData()
    }
    @IBAction func backFromSettings(segue: UIStoryboardSegue) {
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureObserver()  //Notification発行
    }

    // MARK: - Notification

    /// Notification発行
    func configureObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                 name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                 name: UIResponder.keyboardWillHideNotification, object: nil)
        print("Notificationを発行")
    }

    /// キーボードが表示時に画面をずらす。
    @objc func keyboardWillShow(_ notification: Notification?) {
        guard let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        UIView.animate(withDuration: duration) {
            let transform = CGAffineTransform(translationX: 0, y: -(rect.size.height))
            self.view.transform = transform
        }
        print("keyboardWillShowを実行")
    }

    /// キーボードが降りたら画面を戻す
    @objc func keyboardWillHide(_ notification: Notification?) {
        guard let duration = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? TimeInterval else { return }
        UIView.animate(withDuration: duration) {
            self.view.transform = CGAffineTransform.identity
        }
        print("keyboardWillHideを実行")
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
