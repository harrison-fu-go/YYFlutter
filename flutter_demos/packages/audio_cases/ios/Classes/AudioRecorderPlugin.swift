
import AVFoundation
import Flutter

public class AudioRecorerPlugin: NSObject, FlutterPlugin {
    
    
    static var channel: FlutterMethodChannel?
    
    public static func register(with registrar: any FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "audio_recorder", binaryMessenger: registrar.messenger())
        AudioRecorerPlugin.channel = channel
        let instance = AudioRecorerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "startRecording":
            AudioStreamRecording.shared.pcmDelivery = { pcmData in
                let bytes = [UInt8](pcmData)
                AudioRecorerPlugin.channel?.invokeMethod("onReceiveRecordingPcmData", arguments: bytes)
            }
            AudioStreamRecording.shared.start() {state in
                result(state)
            }
        case "stopRecording":
            AudioStreamRecording.shared.pcmDelivery = nil
            AudioStreamRecording.shared.stop()
            result(true)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

public class AudioStreamRecording {
    
    // PCM格式参数
    let sampleRate = 16000  // 创建 16kHz、单声道的采样格式
    let sampleSize = 2      // 16bit = 2字节
    let channels = 1        // 单声道
    let frameDurationMs = 100  // 每帧的时长（毫秒）
    // 计算每帧的样本数和字节数
    lazy var samplesPerFrame = {
        Int(sampleRate * frameDurationMs / 1000)
    }()
    lazy var frameByteSize : UInt32 = {
        UInt32(samplesPerFrame * sampleSize * channels)
    }()
    var savePCMHandle: FileHandle?
    public static let shared = AudioStreamRecording()
    public var pcmDelivery: ((Data) -> Void)?
    var logHeader = "AudioStreamRecorder->"
    var wavWriter: WAVWriter?
    var engine = AVAudioEngine()
    var inputNode: AVAudioInputNode {
        return engine.inputNode
    }
    let bus = 0
    lazy var outputAudioFormat: AVAudioFormat = {
        return AVAudioFormat(commonFormat: .pcmFormatInt16,
                             sampleRate: Double(sampleRate),
                             channels: AVAudioChannelCount(channels),
                             interleaved: false)!
    }()
    
    var outpuConverter: AVAudioConverter?
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleAudioRouteChange),
            name: AVAudioSession.routeChangeNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillTerminate),
            name: UIApplication.willTerminateNotification,
            object: nil
        )
    }
    
    @objc func handleAudioRouteChange(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
              let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else {
            return
        }
        switch reason {
            // 蓝牙断开、插拔耳机、输出设备变更等都要重新配置
        case .oldDeviceUnavailable, .newDeviceAvailable:
            restartAudioEngine()
        case .categoryChange:
            print("\(logHeader)handleAudioRouteChange->categoryChange")
        default:
            break
        }
    }
    
    func restartAudioEngine() {
        print("\(logHeader)-->will go to restart recording...\(engine.isRunning)")
        if (!engine.isRunning) {
            return
        }
        print("\(logHeader)--> go to restart recording...\(engine.isRunning)")
        startRecording()
    }
    
    func resetSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
            try session.setActive(true)
            engine = AVAudioEngine()
            print("\(logHeader)initSession successfully")
        } catch {
            print("\(logHeader)initSession eror:\(error)")
        }
    }
    
    public func start(stateHandle: @escaping (Bool)->Void) {
        requestMicrophonePermission {[weak self] granted in
            if granted {
                self?.startRecording()
            }
            stateHandle(granted)
        }
    }
    
    private func startRecording() {
        resetSession()
        inputNode.removeTap(onBus: 0)
        let audioFormat = inputNode.inputFormat(forBus: 0)
        print("\(logHeader)startRecording-> format: \(audioFormat.sampleRate)")
        //set writer.
        outpuConverter =  AVAudioConverter(from: audioFormat, to: outputAudioFormat)
        if wavWriter == nil {
            let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("recorded_16k.wav")
            wavWriter = try? WAVWriter(outputURL: outputURL, format: outputAudioFormat)
        }
        
        inputNode.installTap(onBus: bus, bufferSize: frameByteSize, format: audioFormat) {[weak self] buffer, time in
            guard let self = self else { return }
            
            // 确保输出缓冲区的大小也是 640 字节
            let bytesPerFrame = Int(self.outputAudioFormat.streamDescription.pointee.mBytesPerFrame)
            guard let outputBuffer = AVAudioPCMBuffer(pcmFormat: self.outputAudioFormat, frameCapacity: AVAudioFrameCount(Int(self.frameByteSize) / bytesPerFrame)) else { return }
            
            var error: NSError?
            let inputBlock: AVAudioConverterInputBlock = { _, outStatus in
                outStatus.pointee = .haveData
                return buffer
            }
            
            // 转换音频
            self.outpuConverter?.convert(to: outputBuffer, error: &error, withInputFrom: inputBlock)
            
            if let error = error {
                print("\(logHeader)convert output audio: \(error)")
            } else {
                // 确保数据的长度是 640 字节
                let channelCount = Int(outputBuffer.format.channelCount)
                let frameLength = Int(outputBuffer.frameLength)
                guard let channelData = outputBuffer.int16ChannelData else { return }
                
                var data = Data(capacity: Int(frameByteSize))
                
                // 拼接每个通道的数据
                for channel in 0..<channelCount {
                    let samples = channelData[channel]
                    let sampleData = Data(bytes: samples, count: frameLength * MemoryLayout<Int16>.size)
                    data.append(sampleData)
                }
                
                // 如果数据小于 640 字节，填充零
                if data.count < frameByteSize {
                    let padding = Data(count: Int(frameByteSize) - data.count)
                    data.append(padding)
                }
                //For test. save pcm data.
                //self.savePCMDataToFile(data)
                // 调用回调
                self.pcmDelivery?(data)
            }
        }
        do {
            try engine.start()
            print("\(logHeader)start recording successfully")
        } catch {
            print("\(logHeader)start recording error: \(error)")
        }
    }
    
    public func stop() {
        inputNode.removeTap(onBus: 0)
        engine.stop()
        wavWriter?.close()
        endSaveDataToFile()
        print("\(logHeader)stop recording successfully")
    }
    
    
    @objc func appWillTerminate() {
        wavWriter?.close()
        print("App 被终止，已尝试关闭文件")
    }
}

extension AudioStreamRecording {
    
    // 保存 PCM 数据到文件
    func savePCMDataToFile(_ data: Data) {
        // 获取保存路径
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let pcmFileURL = documentsURL.appendingPathComponent("recorded_audio.pcm")
        if (savePCMHandle == nil) {
            if fileManager.fileExists(atPath: pcmFileURL.path) {
                try? fileManager.removeItem(at: pcmFileURL)
            }
            // 如果文件不存在，创建文件并写入数据
            try? data.write(to: pcmFileURL)
            savePCMHandle = try? FileHandle(forWritingTo: pcmFileURL)
        } else {
            // 将数据写入到 PCM 文件
            if fileManager.fileExists(atPath: pcmFileURL.path) {
                // 如果文件已存在，追加数据
                savePCMHandle?.seekToEndOfFile()
                savePCMHandle?.write(data)
                print("保存数据。。。。 \(data.count)")
//                savePCMHandle?.closeFile()
            }
        }
    }
    
    func endSaveDataToFile() {
        savePCMHandle?.closeFile()
        savePCMHandle = nil
    }
    
}


extension AudioStreamRecording {
    
    func requestMicrophonePermission(completion: @escaping (Bool) -> Void) {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
}


class WAVWriter {
    private var audioFile: ExtAudioFileRef?
    private var format: AVAudioFormat
    private var fileURL: URL
    
    init(outputURL: URL, format: AVAudioFormat) throws {
        self.format = format
        self.fileURL = outputURL
        
        var file: ExtAudioFileRef?
        let asbd = format.streamDescription
        
        let status = ExtAudioFileCreateWithURL(
            outputURL as CFURL,
            kAudioFileWAVEType,
            asbd,
            nil,
            AudioFileFlags.eraseFile.rawValue,
            &file
        )
        
        guard status == noErr, let unwrappedFile = file else {
            throw NSError(domain: NSOSStatusErrorDomain, code: Int(status), userInfo: nil)
        }
        
        audioFile = unwrappedFile
        
        // 设置客户端写入格式（必须是非交错的）
        try setClientFormat()
    }
    
    private func setClientFormat() throws {
        guard let audioFile = audioFile else { return }
        
        guard let clientFormat = AVAudioFormat(commonFormat: format.commonFormat,
                                               sampleRate: format.sampleRate,
                                               channels: format.channelCount,
                                               interleaved: false) else {
            throw NSError(domain: "WAVWriter", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create client format"])
        }
        
        let status = ExtAudioFileSetProperty(
            audioFile,
            kExtAudioFileProperty_ClientDataFormat,
            UInt32(MemoryLayout<AudioStreamBasicDescription>.size),
            clientFormat.streamDescription
        )
        
        if status != noErr {
            throw NSError(domain: NSOSStatusErrorDomain, code: Int(status), userInfo: nil)
        }
    }
    
    func write(buffer: AVAudioPCMBuffer) throws {
        guard let audioFile = audioFile else { return }
        
        let frameCount = UInt32(buffer.frameLength)
        let status = ExtAudioFileWrite(audioFile, frameCount, buffer.audioBufferList)
        
        if status != noErr {
            throw NSError(domain: NSOSStatusErrorDomain, code: Int(status), userInfo: nil)
        }
    }
    
    func close() {
        if let file = audioFile {
            ExtAudioFileDispose(file)
            audioFile = nil
        }
    }
}
