//
//  ViewController.swift
//  FlutterEngineGroupDemo
//
//  Created by HarrisonFu on 2023/11/9.
//

import UIKit
//import native_demo
import FlutterPluginRegistrant
import Flutter

class ViewController: UIViewController {
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
//        "samples.flutter.dev/battery"
        
    }

    @IBAction func showFlutter1(_ sender: Any) {
        let vc = FlutterBaseVC(entryPoint: "baseMain1", param: "1")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showFlutter2(_ sender: Any) {
        let vc = FlutterBaseVC(entryPoint: "baseMain", param: "3")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

