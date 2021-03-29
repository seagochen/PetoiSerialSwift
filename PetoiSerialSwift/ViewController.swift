//
//  ViewController.swift
//  PetoiSerialSwift
//
//  Created by Orlando Chen on 2021/3/23.
//

import UIKit
import CoreBluetooth
import ActionSheetPicker
import HexColors
import RMessage

class ViewController: UIViewController  {
    
    // 蓝牙设备管理类
    var bluetooth: BluetoothLowEnergy!
    
    // 蓝牙BLE设备
    var peripheral: CBPeripheral?
    
    // 发送数据接口
    var txdChar: CBCharacteristic?
    
    // 接收数据接口
    var rxdChar: CBCharacteristic?
    
    // 接收和发送蓝牙数据
    var bleMsgHandler: BLEMessageDetector?
    
    // 设置蓝牙搜索的pickerview
    var devices: [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 对控件进行调整
        initWidgets()
        
        // 对工具进行初始化
        initUtilities()
    }
    
    
    func initWidgets() {
        // todo
    }
    

    func initUtilities() {
        // 初始化蓝牙
        bluetooth = BluetoothLowEnergy()
        
        // 初始化信道
        bleMsgHandler = BLEMessageDetector()
    }
    
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        
        switch sender.currentTitle {
        case "Search":
            // 开始搜索可用设备
            bluetooth.startScanPeripheral(serviceUUIDS: nil, options: nil)
            
            // 清空列表，避免出现异常
            devices = []
            
            // 修改文字
            sender.setTitle("Stop", for: .normal)

        case "Stop":
            // 停止搜索
            bluetooth.stopScanPeripheral()

            // 把可用设备写入列表中
            let peripherals = bluetooth.getPeripheralList()
            if !peripherals.isEmpty {
                for device in peripherals {
                    if let name = device.name {
                        devices.append(name)
                    }
                }
            }
            
            // 修改文字
            sender.setTitle("Search", for: .normal)
            
            // 弹出提示信息
            if devices.count <= 0 {
                RMessage.showNotification(withTitle: "蓝牙设备搜索失败", subtitle: "未能找到可用的蓝牙设备，请重新尝试!", type: .error, customTypeName: nil, duration: 3, callback: nil)
            } else {
                RMessage.showNotification(withTitle: "找到了可用的设备", subtitle: "找到了\(devices.count)台可用设备", type: .success, customTypeName: nil, duration: 3, callback: nil)
            }
            
        default:
            break
        }
   
    }
    
  

}
