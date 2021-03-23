//
//  ViewController.swift
//  PetoiSerialSwift
//
//  Created by Orlando Chen on 2021/3/23.
//

import UIKit
import CoreBluetooth


class ViewController: UIViewController {
    
    var bluetooth = BluetoothLowEnergy.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        bluetooth.startScanPeripheral(serviceUUIDS: nil, options: nil)
        
    }


}

