//
//  Information.swift
//  AlgoZavr
//
//  Created by Татьяна Шевякова on 23.12.2025.
//

import UIKit

final class AboutAppViewController: UIViewController {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Версия приложения"
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0.1"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        extendedLayoutIncludesOpaqueBars = true

        view.backgroundColor = .systemGray6
    
        setupNavigation()
        setupUI()
        setupConstraints()
    }

    private func setupNavigation() {
        navigationItem.title = "О приложении"
        navigationItem.largeTitleDisplayMode = .always

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray6
        appearance.shadowColor = .clear

        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.label
        ]

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.label
        ]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupUI() {
        view.addSubview(containerView)

        containerView.addSubview(titleLabel)
        containerView.addSubview(versionLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerView.heightAnchor.constraint(equalToConstant: 56),

            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

            versionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            versionLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}


#if DEBUG
import SwiftUI

struct AboutAppViewController_Preview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        UINavigationController(rootViewController: AboutAppViewController())
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

#Preview {
    AboutAppViewController_Preview()
}
#endif
