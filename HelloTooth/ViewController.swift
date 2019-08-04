//
//  ViewController.swift
//  HelloTooth
//
//  Created by Martins on 01/08/2019.
//  Copyright © 2019 Good Gets Better. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {

  lazy var manager: CBCentralManager = {
    return CBCentralManager(delegate: self, queue: DispatchQueue.main)
  }()

  @IBOutlet var console: UITextView!

  let servicelId = "03B80E5A-EDE8-4B33-A751-6CE34EC4C700"

  func startScanning() {
    manager.scanForPeripherals(
      withServices: [CBUUID(string: servicelId)],
      options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
  }

  override func viewWillAppear(_ animated: Bool) {
    if manager.state == .poweredOn && manager.isScanning == false {
      printToConsole("Starting to scan")
      scrollConsoleToBottom()
      startScanning()
    }
  }

  func printToConsole(_ text: String) {
    NSLog(text)
    console.text = console.text.appending(text + "\n")
  }

  func scrollConsoleToBottom() {
    let bottomOffset = CGPoint(
      x: 0,
      y: console.contentSize.height
        - console.bounds.size.height
        + console.contentInset.bottom)
    console.setContentOffset(bottomOffset, animated: false)
  }
}

extension ViewController: CBCentralManagerDelegate {

  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    if manager.state == .poweredOn && manager.isScanning == false {
      printToConsole("Starting to scan")
      scrollConsoleToBottom()
      startScanning()
    }
    switch manager.state {
    case .poweredOff:
      NSLog("State is powered off")
    case .poweredOn:
      NSLog("State is powered on")
    case .resetting:
      NSLog("State is resetting")
    case .unauthorized:
      NSLog("State is unauthorized")
    case .unknown:
      NSLog("State is unknown")
    case .unsupported:
      NSLog("State is unsupported")
    @unknown default:
      NSLog("State is non-documented")
    }
  }

  func centralManager(
    _ central: CBCentralManager,
    didDiscover peripheral: CBPeripheral,
    advertisementData: [String: Any],
    rssi: NSNumber
  ) {
    printToConsole("Did discover a peripheral: \(peripheral), data: \(advertisementData), rssi: \(rssi)")
    scrollConsoleToBottom()
  }
}

