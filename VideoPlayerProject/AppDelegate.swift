//
//  AppDelegate.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-02.
//

import UIKit
import CoreData
import BackgroundTasks
import Photos

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        // Fetch data in background
//        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.akmami.fetchPictures", using: nil) { task in
//            self.handleAppRefreshTask(task: task as! BGAppRefreshTask)
//        }
        
        // Other initialization…
        return true
    }
    
    // MARK: BackgroundTask Handler
    func handleAppRefreshTask(task: BGAppRefreshTask) {
        
        self.scheduleBackgroundPictureFetch()
        
        let refreshQueue = OperationQueue()
        refreshQueue.qualityOfService = .background
        refreshQueue.maxConcurrentOperationCount = 1
        
        let refreshOperation = BlockOperation {
            OperationQueue.main.addOperation {
                print("Okay, its time to do something in background.")
            }
        }
        refreshOperation.completionBlock = {
            task.setTaskCompleted(success: true)
        }
        task.expirationHandler = {
            // Fetch the image and insert it to the CoreData
            let context = self.persistentContainer.viewContext
            let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
            let newImage = FetchedImage(context: context)
            newImage.image = self.assetToUIImage(assets.object(at: 0)).pngData()
            do {
                try context.save()
                print("picture saved succesfully")
            } catch {
                print("Unable to upload image(save)")
            }
            
            // Insert the image to the Core data
            task.setTaskCompleted(success: true)
        }
        
        // Background task codes here
        NotificationCenter.default.post(name: Notification.Name("com.akmami.newPictureFetched"), object: self)
        
    }
    
    func scheduleBackgroundPictureFetch() {
        let request = BGAppRefreshTaskRequest(identifier: "com.akmami.fetchPictures")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 60)
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Fetch is called from scheduleBackgroundPictureFetch()")
        } catch {
          print("Unable to submit task: \(error.localizedDescription)")
        }
    }
    
    func assetToUIImage(_ asset: PHAsset) -> UIImage {
        var resultImage = UIImage()
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .none
        manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options) { (image, _) in
            if let img = image {
                resultImage = img
            }
        }
        return resultImage
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
        let container = NSPersistentContainer(name: "VideoPlayerProject")
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

