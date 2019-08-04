//
//  AppDelegate.swift
//  HelloTooth
//
//  Created by Martins on 01/08/2019.
//  Copyright © 2019 Good Gets Better. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions options: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    NSLog("Launched, options: \(options?.description ?? "nil")")
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    NSLog("App will resign active")
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    NSLog("App entered background")
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    NSLog("App will enter foreground")
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    NSLog("App became active")
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
}

