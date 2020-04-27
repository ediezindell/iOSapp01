//
//  AppDelegate.swift
//  multipage
//
//  Created by 井上義章 on 20200416.
//  Copyright © 2020 井上義章. All rights reserved.
//

import UIKit
import CoreData
import Foundation

var settingFont = "PingFangTC-Light"
var settingFontColor = "8888FF"
var settingFontSize = 16
var firstFocus = false
var firstLaunch = true

class MemoObj: NSObject, NSCoding {
    var title: String
    var body: String
    let created_at: String
    var updated_at: String

    init(title: String, body: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let now = dateFormatter.string(from: Date())

        self.title = title
        self.body = body
        self.created_at = now
        self.updated_at = now
    }

    func updateTitle(title: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let now = dateFormatter.string(from: Date())
        self.title = title
        self.updated_at = now
    }

    func updateBody(body: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let now = dateFormatter.string(from: Date())
        self.body = body
        self.updated_at = now
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(body, forKey: "body")
        aCoder.encode(created_at, forKey: "created_at")
        aCoder.encode(updated_at, forKey: "updated_at")
    }

    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as! String
        body = aDecoder.decodeObject(forKey: "body") as! String
        created_at = aDecoder.decodeObject(forKey: "created_at") as! String
        updated_at = aDecoder.decodeObject(forKey: "updated_at") as! String
    }
}

var memos: [MemoObj] = []

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // 読み込み
        let loadedSettingFont = UserDefaults.standard.object(forKey: "SETTING_FONT")
        if (loadedSettingFont as? String != nil) {
            settingFont = loadedSettingFont as! String
        }
        let loadedSettingFontColor = UserDefaults.standard.object(forKey: "SETTING_FONT_COLOR")
        if (loadedSettingFontColor as? String != nil) {
            settingFontColor = loadedSettingFontColor as! String
        }
        let loadedSettingFontSize = UserDefaults.standard.object(forKey: "SETTING_FONT_SIZE")
        if (loadedSettingFontSize as? Int != nil) {
            settingFontSize = loadedSettingFontSize as! Int
        }
        let loadedFirstFocus = UserDefaults.standard.object(forKey: "FIRST_FOCUS")
        if (loadedFirstFocus as? Bool != nil) {
            firstFocus = (loadedFirstFocus != nil)
        }
        useSettings()

        // メモデータ
        let loadedEncodedMemoData = UserDefaults.standard.object(forKey: "MEMO") as? Data
        guard let m = loadedEncodedMemoData else { return false }
        let unArchiveData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(m)
        memos = unArchiveData as? [MemoObj] ?? [MemoObj(
                        title: "タイトル",
                        body: "ここに内容を入力します"
        )]

        return true
    }

    func useSettings() {
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor(code: settingFontColor)
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: settingFont, size: 19.0), NSAttributedString.Key.foregroundColor: UIColor.white]
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: settingFont, size: 19.0), NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        UILabel.appearance().textColor = UIColor(code: settingFontColor)
        UILabel.appearance().font = UIFont(name: settingFont, size: CGFloat(settingFontSize))
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "multipage")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

