// # Copyright 2025 Yandex LLC. All rights reserved.

import UIKit

public final class ConfettiView: UIView {
    public enum Direction {
        case left
        case right
        case top
        case bottom
    }

    public enum Animation {
        case `default`
    }

    // MARK: - Public Init

    public init(
        emitters: [ConfettiEmitter],
        direction: Direction,
        animation: Animation = .default
    ) {
        self.emitters = emitters
        self.direction = direction
        self.animation = animation
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    override public func willMove(toSuperview newSuperview: UIView?) {
        guard let superview = newSuperview else { return }
        frame = superview.bounds
        isUserInteractionEnabled = false
    }

    public func emit() {
        switch direction {
        case .left:
            emitLeft(emitters, animation: animation)
        case .right:
            emitRight(emitters, animation: animation)
        case .top:
            emitTop(emitters, animation: animation)
        case .bottom:
            emitBottom(emitters, animation: animation)
        }
    }

    public func clear() {
        layer.removeAllAnimations()
        layer.sublayers?.forEach {
            $0.removeAllAnimations()
            $0.removeFromSuperlayer()
        }
    }

    // MARK: - Private Properties

    private let emitters: [ConfettiEmitter]
    private let direction: Direction
    private let animation: Animation

    // MARK: - Private Methods

    private func emitLeft(_ emitters: [ConfettiEmitter], animation: Animation) {
        let confettiLayer = ConfettiLayer(emitters, .left)
        configure(confettiLayer: confettiLayer, animation: animation)
    }

    private func emitRight(_ emitters: [ConfettiEmitter], animation: Animation) {
        let confettiLayer = ConfettiLayer(emitters, .right)
        configure(confettiLayer: confettiLayer, animation: animation)
    }

    private func emitTop(_ emitters: [ConfettiEmitter], animation: Animation) {
        let confettiLayer = ConfettiLayer(emitters, .top)
        configure(confettiLayer: confettiLayer, animation: animation)
    }

    private func emitBottom(_ emitters: [ConfettiEmitter], animation: Animation) {
        let confettiLayer = ConfettiLayer(emitters, .bottom)
        configure(confettiLayer: confettiLayer, animation: animation)
    }

    private func addGravityAnimation(to layer: CAEmitterLayer, emitters: [ConfettiEmitter]) {
        let animation = CAKeyframeAnimation()
        animation.duration = 4.0
        animation.keyTimes = [0, 0.2, 0.4, 0.6, 1]
        animation.values = [10, 20, 40, 80, 4000]
        animation.timingFunction = CAMediaTimingFunction(name: .easeIn)

        for emitter in emitters {
            layer.add(animation, forKey: "emitterCells.\(emitter.id).yAcceleration")
        }
    }

    private func addBirthrateAnimation(to layer: CAEmitterLayer) {
        let animation = CABasicAnimation()
        animation.duration = 1
        animation.fromValue = 1
        animation.toValue = 0

        layer.add(animation, forKey: "birthRate")
        layer.birthRate = 0
    }

    private func configure(
        confettiLayer: ConfettiLayer,
        animation: Animation
    ) {
        confettiLayer.frame = bounds
        confettiLayer.needsDisplayOnBoundsChange = true

        layer.addSublayer(confettiLayer)

        CATransaction.begin()
        switch animation {
        case .default:
            addGravityAnimation(to: confettiLayer, emitters: emitters)
            addBirthrateAnimation(to: confettiLayer)
        }
        CATransaction.commit()
    }
}

// MARK: - Custom Styles

extension ConfettiView {
    public static let top = ConfettiView(
        emitters: Static.defaultEmitters,
        direction: .top,
        animation: .default
    )

    private enum Static {
        static let defaultEmitters: [ConfettiEmitter] = [
            .shape(.rectangle, color: .systemRed),
            .shape(.rectangle, color: .systemPink),
            .shape(.rectangle, color: .systemYellow),
            .shape(.rectangle, color: .systemTeal),
            .shape(.rectangle, color: .systemBlue),
            .shape(.circle, color: .systemGreen),
            .shape(.circle, color: .systemRed),
            .shape(.circle, color: .systemPink),
            .shape(.circle, color: .systemYellow),
            .shape(.circle, color: .systemTeal),
            .shape(.circle, color: .systemBlue),
            .shape(.circle, color: .systemGreen),
        ]
    }
}

public final class ConfettiLayer: CAEmitterLayer {
    // MARK: - Public Types

    public enum Direction {
        case left
        case right
        case top
        case bottom

        var longitude: CGFloat {
            switch self {
            case .left: return .pi * 0.25
            case .right: return .pi * 1.75
            case .top: return .pi
            case .bottom: return 0
            }
        }

        func position(rect: CGRect) -> CGPoint {
            switch self {
            case .left: return CGPoint(x: -50, y: rect.midY)
            case .right: return CGPoint(x: rect.maxX + 50, y: rect.midY)
            case .top: return CGPoint(x: rect.midX, y: -50)
            case .bottom: return CGPoint(x: rect.midX, y: rect.maxY + 50)
            }
        }
    }

    // MARK: - Public Init

    public init(_ emitters: [ConfettiEmitter], _ direction: Direction) {
        self.direction = direction
        super.init()
        configure(emitters, direction)
    }

    override public init(layer: Any) {
        direction = .top
        super.init(layer: layer)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    override public func layoutSublayers() {
        super.layoutSublayers()

        emitterMode = .outline
        emitterShape = .line
        emitterSize = CGSize(width: 1.0, height: 1.0)
        emitterPosition = direction.position(rect: frame)
    }

    // MARK: - Private Properties

    private let direction: Direction

    // MARK: - Private Methods

    private func configure(_ emitters: [ConfettiEmitter], _ direction: Direction) {
        emitterCells = emitters.map { content in
            let cell = CAEmitterCell()

            cell.name = content.id

            cell.contents = content.image.cgImage
            if let color = content.color {
                cell.color = color.cgColor
            }

            cell.beginTime = CACurrentMediaTime()
            cell.birthRate = 100
            cell.lifetime = 10.0

            cell.velocityRange = 1000

            cell.emissionRange = .pi / 2
            cell.emissionLongitude = direction.longitude

            cell.scale = 0.2
            cell.scaleRange = 0.2
            cell.scaleSpeed = 0

            cell.spin = .pi * 3
            cell.spinRange = .pi * 3

            cell.setValue("plane", forKey: "particleType")
            cell.setValue(Double.pi, forKey: "orientationRange")
            cell.setValue(Double.pi / 2, forKey: "orientationLongitude")
            cell.setValue(Double.pi / 2, forKey: "orientationLatitude")

            return cell
        }
    }
}

public enum ConfettiEmitter {
    // MARK: - Public Types

    public enum Shape: Hashable {
        case circle
        case square
        case rectangle
        case custom(CGPath)

        private static var shapesCache: [Shape: UIImage] = [:]
    }

    case shape(Shape, color: UIColor?, id: String = UUID().uuidString)
    case image(UIImage, color: UIColor?, id: String = UUID().uuidString)

    // MARK: - Internal Properties

    var id: String {
        switch self {
        case let .shape(_, _, id), let .image(_, _, id):
            return id
        }
    }

    var color: UIColor? {
        switch self {
        case let .image(_, color, _), let .shape(_, color, _):
            return color
        }
    }

    var image: UIImage {
        switch self {
        case let .shape(shape, _, _):
            return shape.image
        case let .image(image, _, _):
            return image
        }
    }
}

// MARK: - Support Properties

private extension ConfettiEmitter.Shape {
    var image: UIImage {
        if let imageFromCache = Self.shapesCache[self] {
            return imageFromCache
        } else {
            let rect = CGRect(origin: .zero, size: CGSize(width: 20.0, height: 20.0))
            let image = UIGraphicsImageRenderer(size: rect.size).image { context in
                context.cgContext.setFillColor(UIColor.white.cgColor)
                context.cgContext.addPath(path(in: rect))
                context.cgContext.fillPath()
            }
            Self.shapesCache[self] = image
            return image
        }
    }
}

// MARK: - Support Methods

private extension ConfettiEmitter.Shape {
    func path(in rect: CGRect) -> CGPath {
        switch self {
        case .circle, .square:
            return CGPath(ellipseIn: rect, transform: nil)
        case .rectangle:
            let path = CGMutablePath()
            path.addLines(between: [
                CGPoint(x: 0, y: 0),
                CGPoint(x: rect.maxX, y: 0),
                CGPoint(x: rect.maxX, y: rect.maxY / 2),
                CGPoint(x: 0, y: rect.maxY / 2),
            ])
            return path
        case let .custom(path):
            return path
        }
    }
}
