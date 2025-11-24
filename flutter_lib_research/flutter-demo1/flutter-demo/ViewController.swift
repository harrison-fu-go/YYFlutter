//
//  ViewController.swift
//  flutter-demo
//
//  Created by HarrisonFu on 2023/10/20.
//

import UIKit
import Flutter
import flutter_boost
class ViewController: UIViewController {
    let delegate = MyBoostAppDelegate.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make a button to call the showFlutter function when pressed.
//        let button = UIButton(type:UIButton.ButtonType.custom)
//        button.addTarget(self, action: #selector(showFlutter), for: .touchUpInside)
//        button.setTitle("Show Flutter!", for: UIControl.State.normal)
//        button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
//        button.backgroundColor = UIColor.blue
//        self.view.addSubview(button)
        
        let flutterBoost = UIButton(type:UIButton.ButtonType.custom)
        flutterBoost.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        flutterBoost.setTitle("flutterBoost", for: UIControl.State.normal)
        flutterBoost.frame = CGRect(x: 80.0, y: 310.0, width: 160.0, height: 40.0)
        flutterBoost.backgroundColor = UIColor.blue
        self.view.addSubview(flutterBoost)
        
        FlutterBoost.instance().setup(UIApplication.shared, delegate: delegate) { engine in
            debugPrint("=========== what is you? : \(engine?.platformChannel)")
        }
    }

    //    //Flutter boost.
    @objc func clickButton(_ sender: Any) {
        MyBoostAppDelegate.shared.navigationController = self.navigationController
        let options = FlutterBoostRouteOptions()
        options.pageName = "flutterPage"
        FlutterBoost.instance().open(options)
    }
    
//    @objc func showFlutter() {
//        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
//        let flutterViewController =
//        FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
//        present(flutterViewController, animated: true, completion: nil)
//    }
    
}

