//
//  ScannerController.swift
//  HelloTooth
//
//  Created by Martins on 01/08/2019.
//  Copyright © 2019 Good Gets Better. All rights reserved.
//

import UIKit
import CoreBluetooth

class ScannerController: UITableViewController {

  lazy var manager: CBCentralManager = {
    return CBCentralManager(delegate: self, queue: DispatchQueue.main)
  }()

  var discovered = [UUID: CBPeripheral]()

  override func viewWillAppear(_ animated: Bool) {
    if manager.state == .poweredOn && manager.isScanning == false {
      manager.scanForPeripherals(withServices: nil, options: nil)
    }
  }

  override func viewDidDisappear(_ animated: Bool) {
    if manager.isScanning {
      manager.stopScan()
    }
  }
}

extension ScannerController: CBCentralManagerDelegate {

  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    if manager.state == .poweredOn && manager.isScanning == false {
      manager.scanForPeripherals(withServices: nil, options: nil)
    }
  }

  func centralManager(
    _ central: CBCentralManager,
    didDiscover peripheral: CBPeripheral,
    advertisementData: [String: Any],
    rssi: NSNumber
  ) {
    if !discovered.keys.contains(peripheral.identifier) {
      NSLog("Did discover a peripheral: \(peripheral), data: \(advertisementData), rssi: \(rssi)")
      discovered[peripheral.identifier] = peripheral
      if let services = advertisementData[CBAdvertisementDataServiceUUIDsKey] as? [CBUUID] {
        for uuid in services {
          NSLog("Service: \(uuid.uuidString), data: \(uuid.data)")
        }
      }
      manager.connect(peripheral, options: nil)
    }
  }

  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    NSLog("Did connect to peripheral: \(peripheral)")
    peripheral.delegate = self
    peripheral.discoverServices(nil)
  }

  func centralManager(
    _ central: CBCentralManager,
    didFailToConnect peripheral: CBPeripheral,
    error: Error?
  ) {
    NSLog("Failed to connect to \(peripheral), error: \(String(describing: error))")
  }

  func centralManager(
    _ central: CBCentralManager,
    didDisconnectPeripheral peripheral: CBPeripheral,
    error: Error?
  ) {
    NSLog("Did disconnect peripheral: \(peripheral)")
  }
}

extension ScannerController: CBPeripheralDelegate {
  func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
    NSLog("Did discover services: \(peripheral.services?.description ?? "nil"), peripheral: \(peripheral.name?.description ?? "nil")")
    manager.cancelPeripheralConnection(peripheral)
  }
}
