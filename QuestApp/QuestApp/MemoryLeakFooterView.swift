// # Copyright 2025 Yandex LLC. All rights reserved.

import UIKit

class MemoryLeakFooterView: UICollectionReusableView {
    static let identifier = "MemoryLeakFooterView"

    // MARK: - UI Elements

    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel =
        UILabel()
    private let goNextButton = UIButton(type: .system)
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    private let stackView = UIStackView()

    // MARK: - Properties

    weak var delegate: MemoryLeakFooterViewDelegate?
    private var isLoading = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupUI() {
        backgroundColor = .systemBackground

        // Container view
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemGray5.cgColor

        // Stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .center

        // Title label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Готовы продолжить?"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        // Subtitle label
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "Нажмите кнопку ниже, чтобы перейти к следующему шагу"
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0

        // Button setup
        goNextButton.translatesAutoresizingMaskIntoConstraints = false
        goNextButton.setTitle("Go Next", for: .normal)
        goNextButton.setTitleColor(.white, for: .normal)
        goNextButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        goNextButton.backgroundColor = .systemBlue
        goNextButton.layer.cornerRadius = 12
        goNextButton.addTarget(self, action: #selector(goNextButtonTapped), for: .touchUpInside)

        // Loading indicator
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.color = .white

        // Add subviews
        addSubview(containerView)
        containerView.addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(goNextButton)

        goNextButton.addSubview(loadingIndicator)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Container view
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),

            // Stack view
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),

            // Button
            goNextButton.heightAnchor.constraint(equalToConstant: 50),
            goNextButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),

            // Loading indicator
            loadingIndicator.centerXAnchor.constraint(equalTo: goNextButton.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: goNextButton.centerYAnchor),
        ])
    }

    // MARK: - Actions

    @objc private func goNextButtonTapped() {
        guard !isLoading else { return }

        delegate?.footerDidTapGoNext(self)
    }

    // MARK: - Public Methods

    func configure(
        title: String = "Готовы продолжить?",
        subtitle: String = "Нажмите кнопку ниже, чтобы перейти к следующему шагу",
        buttonTitle: String = "Go Next",
        isEnabled: Bool = true
    ) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        goNextButton.setTitle(buttonTitle, for: .normal)
        goNextButton.isEnabled = isEnabled
        goNextButton.alpha = isEnabled ? 1.0 : 0.6
    }

    func setLoading(_ loading: Bool) {
        isLoading = loading

        if loading {
            loadingIndicator.startAnimating()
            goNextButton.setTitle("", for: .normal)
            goNextButton.isEnabled = false
        } else {
            loadingIndicator.stopAnimating()
            goNextButton.setTitle("Go Next", for: .normal)
            goNextButton.isEnabled = true
        }
    }

    func showSuccess() {
        goNextButton.backgroundColor = .systemGreen
        goNextButton.setTitle("✓ Готово", for: .normal)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.goNextButton.backgroundColor = .systemBlue
            self.goNextButton.setTitle("Go Next", for: .normal)
        }
    }

    func showError(_ message: String) {
        goNextButton.backgroundColor = .systemRed
        goNextButton.setTitle(message, for: .normal)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.goNextButton.backgroundColor = .systemBlue
            self.goNextButton.setTitle("Go Next", for: .normal)
        }
    }
}

protocol MemoryLeakFooterViewDelegate: AnyObject {
    func footerDidTapGoNext(_ footer: MemoryLeakFooterView)
}
