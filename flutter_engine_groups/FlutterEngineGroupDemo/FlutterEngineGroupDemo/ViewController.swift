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
//    var vc:FlutterBaseVC?
    let engines = FlutterEngineGroup(name: "kMyEngineGroupIdentifier", project: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        "samples.flutter.dev/battery"
        
    }

    @IBAction func showFlutter1(_ sender: Any) {
        vc = FlutterBaseVC(entryPoint: "main", param: "1")
        let engine = engines.makeEngine(withEntrypoint: "main", libraryURI: nil)
        GeneratedPluginRegistrant.register(with: engine)
        engine.run()
        
        
//        let vc = FlutterBaseVC(entryPoint: "main", param: "1")
//        vc.engine?.run()
//        self.navigationController?.pushViewController(vc, animated: true)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            let vc = FlutterBaseVC(entryPoint: "baseMain", param: "2")
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
//            let vc = FlutterBaseVC(entryPoint: "baseMain1", param: "3")
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
//            let vc = FlutterBaseVC(entryPoint: "baseMain", param: "4")
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
//            let vc = FlutterBaseVC(entryPoint: "baseMain", param: "4")
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
//            let vc = FlutterBaseVC(entryPoint: "baseMain", param: "4")
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
    @IBAction func showFlutter2(_ sender: Any) {
        let vc = FlutterBaseVC(entryPoint: "baseMain", param: "3")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

