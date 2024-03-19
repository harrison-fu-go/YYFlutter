//
//  FlutterBaseVC.swift
//  FlutterEngineGroupDemo
//
//  Created by HarrisonFu on 2023/11/10.
//

import Foundation
import Flutter

public let kBaseNavigateParam = "base.navigate.param"
public let kBaseNavigateInitParam = "base.navigate.init.param"
public let kBaseNavigateChannelIdentifier = "base.navigate.channel.identifier"
open class FlutterBaseVC: FlutterViewController {
    
    var channel: FlutterBasicMessageChannel?
    var isSetParamToFlutter = false
    open var identifier: String {
        let str = "identifier.\(Unmanaged.passUnretained(self).toOpaque())"
        return str
    }
    
    public init(entryPoint: String?, param: String? = nil) {
        let engine = EngineGroupMgr.share.createEngineAndChannel(entryPoint: entryPoint, channel: kBaseNavigateParam)
        self.channel = engine.c
        super.init(engine: engine.e, nibName: nil, bundle: nil)
        self.channel?.setMessageHandler {[weak self] message, reply in
            guard let self = self else { return }
            if let param = param, let message = message as? String, message == kBaseNavigateInitParam, !self.isSetParamToFlutter {
                reply([kBaseNavigateChannelIdentifier: self.identifier, kBaseNavigateInitParam:param])
                self.isSetParamToFlutter = true
                return
            }
            self.isSetParamToFlutter = true
            self.onMessageUpdate(message: message)
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    open func onMessageUpdate(message: Any?) {
        print("========= \(String(describing: message))")
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.channel = nil
    }
}
