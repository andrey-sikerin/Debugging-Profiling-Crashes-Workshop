//
//  PasswordLockScreenViewController.swift
//  QuestApp

import UIKit

#if USE_QUESTCORE_FRAMEWORK

    import QuestCore

#endif

final class PasswordLockScreenViewController: UIViewController {
    var model: PasswordLockModel! {
        didSet {
            model.passwordLockUI = self
        }
    }

    private let passwordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .systemGray6
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let realPasswordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Generated Password"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let generatedPasswordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .systemGray6
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var generateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Generate Password", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(generatePasswordTapped),
            for: .touchUpInside
        )
        return button
    }()

    private lazy var checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Check Password", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(checkPasswordTapped),
            for: .touchUpInside
        )
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(passwordTitleLabel)
        view.addSubview(passwordLabel)
        view.addSubview(realPasswordTitleLabel)
        view.addSubview(generatedPasswordLabel)
        view.addSubview(generateButton)
        view.addSubview(checkButton)

        NSLayoutConstraint.activate([
            passwordTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.1),
            passwordTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),

            passwordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordLabel.topAnchor.constraint(equalTo: passwordTitleLabel.bottomAnchor, constant: 8),
            passwordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            passwordLabel.heightAnchor.constraint(equalToConstant: 44),

            realPasswordTitleLabel.leadingAnchor.constraint(equalTo: passwordTitleLabel.leadingAnchor),
            realPasswordTitleLabel.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 20),

            generatedPasswordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generatedPasswordLabel.topAnchor.constraint(equalTo: realPasswordTitleLabel.bottomAnchor, constant: 8),
            generatedPasswordLabel.widthAnchor.constraint(equalTo: passwordLabel.widthAnchor),
            generatedPasswordLabel.heightAnchor.constraint(equalTo: passwordLabel.heightAnchor),

            generateButton.leadingAnchor.constraint(equalTo: passwordLabel.leadingAnchor),
            generateButton.topAnchor.constraint(equalTo: generatedPasswordLabel.bottomAnchor, constant: 40),
            generateButton.widthAnchor.constraint(equalTo: passwordLabel.widthAnchor, multiplier: 0.48),
            generateButton.heightAnchor.constraint(equalToConstant: 50),

            checkButton.trailingAnchor.constraint(equalTo: passwordLabel.trailingAnchor),
            checkButton.topAnchor.constraint(equalTo: generatedPasswordLabel.bottomAnchor, constant: 40),
            checkButton.widthAnchor.constraint(equalTo: passwordLabel.widthAnchor, multiplier: 0.48),
            checkButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    @objc private func generatePasswordTapped() {
        model.generatePassword()
    }

    @objc private func checkPasswordTapped() {
        model.checkPassword()
    }
}

extension PasswordLockScreenViewController: PasswordLockUI {
    func updatePassword(_ password: String) {
        passwordLabel.text = password
    }

    func updateGeneratedPassword(_ password: String) {
        generatedPasswordLabel.text = password
    }
}
