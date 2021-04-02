//
//  BLECmdStackHandler.swift
//  PetoiSerialSwift
//
//  Created by Orlando Chen on 2021/4/2.
//

import UIKit
import Foundation


class BLESignalStackHandler: BLECommunicationHandler {
    
    var tokens = Array<(cmd: String, feedback: String)>()
    
    // 舵机角度信息
    var motors = [Int](repeating: 10, count: 16)
    
    // 文本输出
    private var output: UITextView!
    
    init(textview: UITextView, delegate: AppDelegate) {
        self.output = textview
        
        // bluetooth communication handler
        super.init(textview: textview, delegate: delegate, receive: { (_ msg: String) in
            // TODO
        })
    }
    
    
    func calibrationFeedbackCheck() {
        
        while true {
            
            let token = popupToken()
            if token.cmd == "" {
                break
            }
            
            if token.cmd.contains("c") && token.feedback.count > 10 { // found c
                let splits = token.feedback.split(separator: "\r\n")
                let deg = splits[2].split(separator: ",")
                
                for i in 0...15 {
                    motors[i] = Int(deg[i])!
                }
                
                break
            }
        }
        
        for i in 0...15 {
            print("steering \(i): \(motors[i])")
        }
//
//        for (int i = 0; i < MOTORS; i ++) {
//            qDebug() << "steering " << i << ": " << motors[i];
//        }
        
    }
    
    func sendCmdViaSerial(cmd: String) {
        let final: (cmd: String, feedback: String) = (cmd: cmd, feedback: "")
        
        // always keeps the size to 15;
        if (tokens.count > 15) {
            tokens.removeFirst()
        }
        
        pushToken(token: final)
        
        
        
 
//        handler.sendCmdViaSerial(cmd: cmd)
        print("sent: \(cmd)")
    };
    

    func isEmpty() -> Bool {
        return tokens.isEmpty
    };

    func pushToken(token: (cmd: String, feedback: String)) {
        
        var final: (cmd: String, feedback: String) = token
        
        if token.feedback.contains("\t") {
            let replaced = token.feedback.replacingOccurrences(of: "\t", with: ",")
            final.feedback = replaced
        }
        
        if token.feedback.contains(",,") {
            let replaced = token.feedback.replacingOccurrences(of: ",,", with: ",")
            final.feedback = replaced
        }
         
        tokens.append(final)
    }

    func popupToken() -> (cmd: String, feedback: String) {
        
        if tokens.count > 0 {
            let token = tokens.removeLast()
            return token
        }
        
        return (cmd: "", feedback: "")
    };
    
    func debugStack() {
        print("stack info----\(tokens.count)")
        
        for token in tokens {
            print(">>>\(token.cmd)<<<<>>>\(token.feedback)<<<")
        }
    };
}
