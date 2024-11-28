//
//  UIViewController.swift
//  SFSpeechRecognizer
//
//  Created by lymanny on 28/11/24.
//

import UIKit

extension UIViewController {
    func addFeedbackGenerator(completion: (() -> Void)? = nil) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        feedbackGenerator.impactOccurred()
        completion?()
    }
}

