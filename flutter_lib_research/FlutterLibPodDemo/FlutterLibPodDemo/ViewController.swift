//
//  ViewController.swift
//  FlutterLibPodDemo
//
//  Created by HarrisonFu on 2023/10/31.
//

import UIKit
import Flutter
import flutter_boost

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let button = UIButton(type:UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(showFlutter), for: .touchUpInside)
        button.setTitle("Show Flutter!", for: UIControl.State.normal)
        button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
        button.backgroundColor = UIColor.blue
        self.view.addSubview(button)

        // Do any additional setup after loading the view.
        let flutterBoost = UIButton(type:UIButton.ButtonType.custom)
        flutterBoost.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        flutterBoost.setTitle("flutterBoost", for: UIControl.State.normal)
        flutterBoost.frame = CGRect(x: 80.0, y: 310.0, width: 160.0, height: 40.0)
        flutterBoost.backgroundColor = UIColor.blue
        self.view.addSubview(flutterBoost)
    }
    
    @objc func showFlutter() {
        var flutterEngine = FlutterEngine(name: "my flutter engine")
        flutterEngine.run()
        let flutterVC = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        self.present(flutterVC, animated: true)
    }
    
//    //Flutter boost.
    @objc func clickButton(_ sender: Any) {
        debugPrint("===== On click: flutter boost. ")
        MyBoostAppDelegate.shared.navigationController = self.navigationController
        let options = FlutterBoostRouteOptions()
        options.pageName = "flutterPage"
        options.onPageFinished = { info in
            debugPrint("=======1: \(info)")
        }
        options.completion = {val in
            debugPrint("=======2: \(val)")
        }
//        FlutterBoost.instance().open(options)
        FlutterBoost.instance().open(options)
    }
}

