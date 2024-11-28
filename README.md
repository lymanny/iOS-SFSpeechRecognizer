
# 🎙️ Speech Recognizer with Lottie Animations

## Overview 📚
A sample project that implements real-time speech-to-text transcription using Apple's `Speech` framework.

## Features 🔑
- **Speech Recognition**: Real-time transcription using Apple's `Speech` framework.
- **Lottie Animations**: Visual feedback during voice input.
- **User-Friendly Interface**: Simple design for seamless interaction.

## Requirements 📋
- iOS 14.0+
- Xcode 12.0+
- Swift 5.0

## Demo 🎥
### Speech Recognizers (English and Korean)
<p align="center">
  <img src="https://github.com/user-attachments/assets/b04f6230-c95b-4ac2-bac8-5ba8c3042afd" alt="English Speech Recognizer" width="400"/>
  <img src="https://github.com/user-attachments/assets/094bf4ef-4a31-4556-b020-8c719faedd2a" alt="Korean Speech Recognizer" width="400"/>
</p>

## Usage 🛠️
1. **Clone the repository**:
    ```bash
    git clone https://github.com/lymanny/iOS-SFSpeechRecognizer.git
    ```
2. Open the project in Xcode.
3. Run the app on an iOS device or simulator.
4. Start speaking to see the real-time transcription!

## Permissions 🔐
Add the following to your `Info.plist` file:
```xml
<key>NSMicrophoneUsageDescription</key>
<string>We need access to your microphone for speech recognition.</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>We need access to transcribe your voice.</string>
```

## Limitations ⚠️
- Does not automatically detect spoken language; you must specify the language in the code.
- **English Speech Recognizer**  
  `SFSpeechRecognizer(locale: Locale(identifier: "en-US"))`  
- **Korean Speech Recognizer**  
  `SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))`  

## Contributing 🤝
Contributions are welcome! Please feel free to submit issues, fork the repository, and create pull requests.

## License 📄
This project is licensed under the [MIT License](LICENSE).

## Author 👩‍💻
lymanny - iOS Developer  
🌐 [Portfolio](https://lymanny.onrender.com)
