//
//  DemoVC.swift
//  FlutterEngineGroupDemo
//
//  Created by HarrisonFu on 2024/3/18.
//

import UIKit
//import native_demo
//import Flutter

class DemoVC: FlutterBaseVC {
    
//    override init(entryPoint: String?, param: String? = nil) {
//        super.init(entryPoint: entryPoint, param: param)
//        if let engine = self.engine {
//            NativeDemoPlugin.register(with: engine as! FlutterPluginRegistrar) //FlutterPluginRegistrar
//        }
//    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
