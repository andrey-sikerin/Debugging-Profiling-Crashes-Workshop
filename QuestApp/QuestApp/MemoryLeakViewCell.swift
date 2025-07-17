// # Copyright 2025 Yandex LLC. All rights reserved.

import UIKit

#if USE_QUESTCORE_FRAMEWORK

    import QuestCore

#endif

class MemoryLeakViewCell: UICollectionViewCell {
    static let identifier = "MemoryLeakViewCell"

    // MARK: - UI Elements

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    private let gradientLayer = CAGradientLayer()
    private var disposable: Disposable? = nil

    // MARK: - Properties

    private var currentImageUrl: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = imageView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        currentImageUrl = nil
        loadingIndicator.stopAnimating()
    }

    // MARK: - Setup

    private func setupUI() {
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemGray6

        // ImageView setup
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        // Gradient setup
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.7).cgColor,
        ]
        gradientLayer.locations = [0.7, 1.0]
        imageView.layer.addSublayer(gradientLayer)

        // Title label setup
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)

        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2

        // Loading indicator setup
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.hidesWhenStopped = true

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(loadingIndicator)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // ImageView
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            // Title Label
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            // Loading Indicator
            loadingIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    // MARK: - Configuration

    func configure(
        with model: ImageModel,
        imageManager: ImageManager
    ) {
        titleLabel.text = model.title
        currentImageUrl = model.url

        // Загрузка изображения
        loadingIndicator.startAnimating()
        loadImage(from: model.url, imageManager: imageManager)
    }

    private func loadImage(from urlString: String, imageManager: ImageManager) {
        guard let url = URL(string: urlString) else {
            loadingIndicator.stopAnimating()
            return
        }

        disposable = imageManager.loadImage(from: url) { result in
            switch result {
            case let .success(image):
                self.onImageLoaded(urlString: urlString, image: image)
            case .failure:
                self.loadingIndicator.stopAnimating()
            }
        }
    }

    private func onImageLoaded(urlString: String, image: UIImage) {
        guard currentImageUrl == urlString else {
            loadingIndicator.stopAnimating()
            return
        }

        // Анимированное появление
        imageView.alpha = 0
        imageView.image = image
        loadingIndicator.stopAnimating()

        UIView.animate(withDuration: 0.3) {
            self.imageView.alpha = 1
        }
    }
}
