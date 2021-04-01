//
//  CalibrationViewController.swift
//  PetoiSerialSwift
//
//  Created by Orlando Chen on 2021/3/31.
//

import UIKit
import CoreBluetooth
import HexColors
import RMessage
import ActionSheetPicker_3_0


class CalibrationViewController: UIViewController {
    
    @IBOutlet weak var servoLabel: UILabel!
    @IBOutlet weak var servoBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var OKBtn: UIButton!
    @IBOutlet weak var outputTextview: UITextView!
    
    
    var bluetooth: BluetoothLowEnergy!  // 蓝牙设备管理类
    var peripheral: CBPeripheral?  // 蓝牙BLE设备
    var txdChar: CBCharacteristic?  // 发送数据接口
    var rxdChar: CBCharacteristic?  // 接收数据接口
    var bleMsgHandler: BLEMessageDetector?  // 接收和发送蓝牙数据
    var devices: [CBPeripheral]!  // 设置蓝牙搜索的pickerview
    
    
    // MARK: view被创建后，初始化一些基础设置
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 对控件进行调整
        initWidgets()
        
        // 对信道蓝牙相关通信做准备
        loadBleInformation()
    }
    
    // MARK: view即将被销毁前，把蓝牙设备信息存放回delegate，其实不用存放bluetooth，不过为了工整
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveBleInformation()
    }
    
    
    // MARK：对蓝牙等设备初始化
    func loadBleInformation() {
        
        // 从AppDelegate获取存放在全局的蓝牙等外设信息
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        bluetooth = delegate.bluetooth
        peripheral = delegate.peripheral
        txdChar = delegate.txdChar
        rxdChar = delegate.rxdChar
        bleMsgHandler = delegate.bleMsgHandler
        devices = delegate.devices
    }
    
    
    func saveBleInformation() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.bluetooth = bluetooth
        delegate.peripheral = peripheral
        delegate.txdChar = txdChar
        delegate.rxdChar = rxdChar
        delegate.bleMsgHandler = bleMsgHandler
        delegate.devices = devices
    }
    
    
    // MARK: 对面板控件进行初始化的函数
    func initWidgets() {
        /**
         * 标签风格
         */
        // 下划线的形式
        WidgetTools.underline(label: servoLabel)
        // 修改标签内容
        servoLabel.text = "Servo: None"
       
      
        /**
         * 按钮
         */
        // 给按钮设置为圆角矩形
        WidgetTools.roundCorner(button: servoBtn)
        WidgetTools.roundCorner(button: clearBtn)
        WidgetTools.roundCorner(button: saveBtn)
        WidgetTools.roundCorner(button: OKBtn)
        
        
        /**
         * 文本背景设置为透明
         */
        WidgetTools.transparent(textView: outputTextview, alpha: 0.4)
    }
    
    // MARK: 不干什么事，主要在用户点击OK按钮后退出当前的界面，回到上级界面
    @IBAction func OKBtnPressed(_ sender: UIButton) {
        bluetooth.sendData(data: Converter.cvtString(toData: "d"), peripheral: peripheral!, characteristic: txdChar!)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK:
    @IBAction func fineAdjStepperPressed(_ sender: UIStepper) {
    }
    
    // MARK:
    @IBAction func servoSelectBtnPressed(_ sender: Any) {
    }
    
    // MARK:
    @IBAction func clearBtnPressed(_ sender: Any) {
    }
    
    // MARK:
    @IBAction func saveBtnPressed(_ sender: Any) {
    }
    
}
