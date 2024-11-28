//
//  VoiceSearchVC.swift
//  SFSpeechRecognizer
//
//  Created by lymanny on 26/11/24.
//

import UIKit
import Speech
import Lottie

class VoiceSearchVC: UIViewController, SFSpeechRecognizerDelegate {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var viewAnimation        : LottieAnimationView!
    @IBOutlet weak var textViewVoiceDisplay : UITextView!
    
    //MARK: - Properties
    private let speechRecognizer   = SFSpeechRecognizer(locale: Locale(identifier: "en-US")) //does not automatically detect the language being spoken
    private let speechRecognizerKo = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR")) //does not automatically detect the language being spoken
    private let audioEngine        = AVAudioEngine()
    private var recognitionRequest : SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask    : SFSpeechRecognitionTask?
    var onRecognitionComplete      : ((String) -> Void)?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        requestSpeechAuthorization()
    }
    
    //MARK: - @IBAction
    @IBAction func closeClick(_ sender: Any) {
        stopListening()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchClick(_ sender: Any) {
        self.dismiss(animated: true) {
            self.onRecognitionComplete?(self.textViewVoiceDisplay.text)
        }
        
    }
    
    //MARK: - Function
    func setupUI() {
        textViewVoiceDisplay.text = "Say something, I'm listening!"
        textViewVoiceDisplay.textColor = .gray
        setupAnimation()
    }
    
    func setupAnimation() {
        viewAnimation.backgroundColor = .clear
        viewAnimation.loopMode = .loop
        viewAnimation.stop() // Ensure animation is initially stopped
    }
    
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { [weak self] status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    self?.startListening()
                case .denied, .restricted, .notDetermined:
                    self?.textViewVoiceDisplay.text = "Speech recognition authorization failed."
                    self?.viewAnimation.stop()
                @unknown default:
                    fatalError("Unexpected authorization status")
                }
            }
        }
    }
    
    func startListening() {
        guard let speechRecognizer = speechRecognizer, speechRecognizer.isAvailable else {
            textViewVoiceDisplay.text = "Speech recognizer is not available."
            return
        }
        
        do {
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = recognitionRequest else { return }
            
            recognitionRequest.shouldReportPartialResults = true
            
            let inputNode = audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                recognitionRequest.append(buffer)
            }
            
            audioEngine.prepare()
            try audioEngine.start()
            
            recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] result, error in
                guard let self = self else { return }
                
                if let result = result {
                    let spokenText = result.bestTranscription.formattedString
                    
                    if !spokenText.isEmpty {
                        // Start animation if there's voice input
                        self.viewAnimation.play()
                        self.textViewVoiceDisplay.text = spokenText
                        self.textViewVoiceDisplay.textColor = .black
                    } else {
                        // Stop animation when there's no voice
                        self.viewAnimation.stop()
                    }
                    
                    if result.isFinal {
                        self.stopListening()
                        self.viewAnimation.stop()
                        self.dismiss(animated: true) {
                            self.onRecognitionComplete?(spokenText)
                        }
                    }
                } else if let error = error {
                    print("Speech recognition error: \(error)")
                    self.stopListening()
                    self.viewAnimation.stop()
                }
            }
        } catch {
            print("Error starting the audio engine: \(error)")
            stopListening()
        }
    }
    
    func stopListening() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        recognitionRequest = nil
        recognitionTask = nil
        viewAnimation.stop() //stop animation
    }
    
}
