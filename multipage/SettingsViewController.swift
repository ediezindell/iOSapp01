//
//  ViewController.swift
//  multipageEditViewController
//
//  Created by 井上義章 on 20200416.
//  Copyright © 2020 井上義章. All rights reserved.
//

import UIKit

let settingSections = ["フォント設定", "その他"]
var settingData = [
    [], // フォント設定
    [], // その他
]

class SettingsViewController: UIViewController, UIFontPickerViewControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    // セクション内データ
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingSections[section]
    }
    // セクション内データ数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingData[section].count
    }
    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingSections.count
    }
    // セクションの高さ
    func tableView(_ tableView: UITableView, heightForHeaderInSection: Int) -> CGFloat {
        return 40
    }
    // セルの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell;
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "FontSettiingCell", for: indexPath)
        } else if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "FontColorSettiingCell", for: indexPath)
        } else {//} if indexPath.row == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "FontSizeSettiingCell", for: indexPath)
        }

        //各要素にはタグでアクセスする
        let settingLabel: UILabel = cell.viewWithTag(1)! as! UILabel
        settingLabel.font = UIFont(name: settingFont, size: CGFloat(settingFontSize))
        settingLabel.textColor = UIColor.colorFromRGB(rgb: settingFontColor, alpha: 1)

        //各要素にはタグでアクセスする
        let nowSettingLabel: UILabel = cell.viewWithTag(2)! as! UILabel
        // フォントサイズ
        if indexPath.row == 2 {
            nowSettingLabel.text = "\(settingData[indexPath.section][indexPath.row])px"
        } else {
            nowSettingLabel.text = settingData[indexPath.section][indexPath.row] as? String
        }
        nowSettingLabel.font = UIFont(name: settingFont, size: CGFloat(settingFontSize))
        nowSettingLabel.textColor = UIColor.colorFromRGB(rgb: settingFontColor, alpha: 1)

        return cell
    }
    // セクションの中身
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let sectionLabel = UILabel()
//
//        sectionLabel.font = UIFont(name: settingFont, size: (sectionLabel.font.pointSize))
//        sectionLabel.textColor = UIColor.colorFromRGB(rgb: settingFontColor, alpha: 1)
//        sectionLabel.text = settingSections[section]
//
//        let headerView = UIView()
//        headerView.addSubview(sectionLabel)
//
//        return headerView
//    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
//        useSettings()
        settingData[0] = [settingFont, settingFontColor, String(settingFontSize)]
//        settingData[1] = UIFont.familyNames
//        UILabel.apperance().font = UIFont(name: settingFont, size: CGFloat(settingFontSize))

        settingTable.frame = view.frame
        settingTable.dataSource = self
        settingTable.delegate = self
        settingTable.tableFooterView = UIView(frame: .zero)
            
//        self.hoge?.textColor = UIColor.colorFromRGB(rgb: settingFontColor, alpha: 1)
//        self.hoge?.font = UIFont(name: settingFont, size: CGFloat(settingFontSize))
    }
    
    @IBOutlet weak var settingTable: UITableView!

    private func selectFont() {
        let fontPickerConfig = UIFontPickerViewController.Configuration()
        fontPickerConfig.includeFaces = true
        fontPickerConfig.displayUsingSystemFont = false
        fontPickerConfig.filteredLanguagesPredicate = UIFontPickerViewController.Configuration.filterPredicate(forFilteredLanguages: ["ja"])
        let fontPicker = UIFontPickerViewController(configuration: fontPickerConfig)
        fontPicker.delegate = self
        self.present(fontPicker, animated: true, completion: nil)
    }
    private func selectColor() {
        self.performSegue(withIdentifier: "toColorSetting", sender: self)
        print("now color select")
    }
    private func selectSize() {
        self.performSegue(withIdentifier: "toSizeSetting", sender: self)
        print("now size select")
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if indexPath.section == 0 && indexPath.row == 0 {
            selectFont()
        } else if indexPath.section == 0 && indexPath.row == 1 {
            selectColor()
        } else if indexPath.section == 0 && indexPath.row == 2 {
            selectSize()
        }

        print("[\(indexPath.section)][\(indexPath.row)]番目の行が選択されました。")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // UIFontPickerViewControllerDelegate - 選択後
    func fontPickerViewControllerDidPickFont(_ fontPicker: UIFontPickerViewController) {
        if let fontName = fontPicker.selectedFontDescriptor?.postscriptName {
            print("set FontName: \(fontName)")
            settingFont = fontName
            settingData[0][0] = fontName
            UserDefaults.standard.set(fontName, forKey: "SETTING_FONT")
            settingTable?.reloadData()
        }
    }

    // キャンセル
    func fontPickerViewControllerDidCancel(_ viewController: UIFontPickerViewController) {
        print("Cancel")
    }

    @IBAction func canselFromColorSetting(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        settingData[0][1] = settingFontColor
        settingData[0][2] = settingFontSize
        UserDefaults.standard.set(settingFontColor, forKey: "SETTING_FONT_COLOR")
        UserDefaults.standard.set(settingFontSize, forKey: "SETTING_FONT_SIZE")
        settingTable?.reloadData()
    }
}

