//
//  EngineGroupMgr.swift
//  FlutterEngineGroupDemo
//
//  Created by HarrisonFu on 2023/11/10.
//

import Foundation
import Flutter
import FlutterPluginRegistrant
public class EngineGroupMgr: NSObject {
    
    static let share = EngineGroupMgr()
    
    let engines = FlutterEngineGroup(name: "kMyEngineGroupIdentifier", project: nil)
    
    public func initBase() { }
    /**
     Create engine and channel, if channel is nil, then would not create the channel.
     */
    func createEngineAndChannel(entryPoint: String?,
                                channel: String? = nil) -> (e:FlutterEngine, c:FlutterBasicMessageChannel?) {
        let engine = self.createEngine(entryPoint: entryPoint)
        var channelObj: FlutterBasicMessageChannel?
        if let channel = channel {
            channelObj = self.createChannel(channel: channel, engine: engine)
        }
        return (engine, channelObj)
    }

    /**
     create engine
     */
    func createEngine(entryPoint: String?) -> FlutterEngine {
        let engine = self.engines.makeEngine(withEntrypoint: entryPoint, libraryURI: nil)
        GeneratedPluginRegistrant.register(with: engine)
        print("====== Did create engine: \(engine)")
        return engine
    }
    
    /**
        Create method channel
     */
    func createChannel(channel: String, engine: FlutterEngine) -> FlutterBasicMessageChannel {
        let channel = FlutterBasicMessageChannel(name: channel, binaryMessenger: engine.binaryMessenger)
        print("====== Did create channel: \(channel)")
        return channel
    }
    
}



