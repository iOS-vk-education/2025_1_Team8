//
//  AboutAppViewControllerWrapper.swift
//  AlgoZavr
//
//  Created by Татьяна Шевякова on 23.12.2025.
//

import SwiftUI
import UIKit

struct AboutAppViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = AboutAppViewController()
        return UINavigationController(rootViewController: vc)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
