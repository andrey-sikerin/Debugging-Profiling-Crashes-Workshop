// # Copyright 2025 Yandex LLC. All rights reserved.

import UIKit

#if USE_QUESTCORE_FRAMEWORK

    import QuestCore

#endif

final class ViewHierarchyViewController: UIViewController {
    var model: ViewHierarchyModel!

    private let buttonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 35
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        // Base container views
        let button = model.button
        let containerView1 = createBaseView(backgroundColor: .red.withAlphaComponent(0.3))
        let containerView2 = createBaseView(backgroundColor: .blue.withAlphaComponent(0.3))

        // Add containers to main view
        view.addSubview(containerView1)
        view.addSubview(containerView2)

        view.addSubview(buttonBackgroundView)
        view.addSubview(button)

        let circleView = createRoundView(backgroundColor: .orange.withAlphaComponent(0.5))
        let trapezoidView = createTrapezoidView()
        let triangleView = createTriangleView()

        view.addSubview(circleView)
        view.addSubview(trapezoidView)
        view.addSubview(triangleView)

        // Add new views
        let diagonalView = createDiagonalStripesView()
        let curvedView = createCurvedView()
        let randomSquaresView = createRandomSquaresView()

        view.addSubview(diagonalView)
        view.addSubview(curvedView)
        view.addSubview(randomSquaresView)

        let v = model.view
        view.addSubview(v)

        // Add new abstract views
        let waveView = createWavePatternView()
        let concentricView = createConcentricCirclesView()
        let mosaicView = createMosaicView()

        view.addSubview(waveView)
        view.addSubview(concentricView)
        view.addSubview(mosaicView)

        // Create center abstract views
        let centerSpiral = createSpiralView()
        let centerBlobs = createBlobsView()
        let centerDots = createDotsPatternView()

        view.addSubview(centerSpiral)
        view.addSubview(centerBlobs)
        view.addSubview(centerDots)

        let colorfulSquares = createColorfulSquaresView()
        let diamondView = createDiamondView()
        let starView = createStarView()

        view.addSubview(colorfulSquares)
        view.addSubview(diamondView)
        view.addSubview(starView)

        // Setup constraints
        NSLayoutConstraint.activate([
            // Container 1
            containerView1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            containerView1.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),

            // Container 2
            containerView2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            containerView2.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),

            // Button Background View - moved to top right
            buttonBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            buttonBackgroundView.widthAnchor.constraint(equalToConstant: 140),
            buttonBackgroundView.heightAnchor.constraint(equalToConstant: 70),

            // Next Button - centered in background view
            button.centerXAnchor.constraint(equalTo: buttonBackgroundView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: buttonBackgroundView.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 120),
            button.heightAnchor.constraint(equalToConstant: 50),

            // FirstScreenView - positioned below button in top right
            v.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            v.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10), // Move it slightly above button
            v.widthAnchor.constraint(equalToConstant: 200),
            v.heightAnchor.constraint(equalToConstant: 200),

            // Circle View
            circleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            circleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            circleView.widthAnchor.constraint(equalToConstant: 80),
            circleView.heightAnchor.constraint(equalToConstant: 80),

            // Trapezoid View
            trapezoidView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trapezoidView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            trapezoidView.widthAnchor.constraint(equalToConstant: 120),
            trapezoidView.heightAnchor.constraint(equalToConstant: 100),

            // Triangle View
            triangleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            triangleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            triangleView.widthAnchor.constraint(equalToConstant: 100),
            triangleView.heightAnchor.constraint(equalToConstant: 100),

            // Diagonal Stripes View
            diagonalView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            diagonalView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            diagonalView.widthAnchor.constraint(equalToConstant: 200),
            diagonalView.heightAnchor.constraint(equalToConstant: 200),

            // Curved View
            curvedView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            curvedView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            curvedView.widthAnchor.constraint(equalToConstant: 100),
            curvedView.heightAnchor.constraint(equalToConstant: 100),

            // Random Squares View
            randomSquaresView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            randomSquaresView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            randomSquaresView.widthAnchor.constraint(equalToConstant: 150),
            randomSquaresView.heightAnchor.constraint(equalToConstant: 150),

            // Wave Pattern View
            waveView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            waveView.topAnchor.constraint(equalTo: buttonBackgroundView.bottomAnchor, constant: 40),
            waveView.widthAnchor.constraint(equalToConstant: 150),
            waveView.heightAnchor.constraint(equalToConstant: 50),

            // Concentric Circles View
            concentricView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            concentricView.topAnchor.constraint(equalTo: buttonBackgroundView.bottomAnchor, constant: 60),
            concentricView.widthAnchor.constraint(equalToConstant: 100),
            concentricView.heightAnchor.constraint(equalToConstant: 100),

            // Mosaic View
            mosaicView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mosaicView.topAnchor.constraint(equalTo: buttonBackgroundView.bottomAnchor, constant: 40),
            mosaicView.widthAnchor.constraint(equalToConstant: 100),
            mosaicView.heightAnchor.constraint(equalToConstant: 100),

            // Center Spiral View
            centerSpiral.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerSpiral.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerSpiral.widthAnchor.constraint(equalToConstant: 200),
            centerSpiral.heightAnchor.constraint(equalToConstant: 200),

            // Center Blobs View
            centerBlobs.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50),
            centerBlobs.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
            centerBlobs.widthAnchor.constraint(equalToConstant: 150),
            centerBlobs.heightAnchor.constraint(equalToConstant: 150),

            // Center Dots Pattern View
            centerDots.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50),
            centerDots.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            centerDots.widthAnchor.constraint(equalToConstant: 180),
            centerDots.heightAnchor.constraint(equalToConstant: 180),

            // Colorful Squares View
            colorfulSquares.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            colorfulSquares.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            colorfulSquares.widthAnchor.constraint(equalToConstant: 150),
            colorfulSquares.heightAnchor.constraint(equalToConstant: 150),

            // Diamond View
            diamondView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            diamondView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250),
            diamondView.widthAnchor.constraint(equalToConstant: 100),
            diamondView.heightAnchor.constraint(equalToConstant: 100),

            // Star View
            starView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            starView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            starView.widthAnchor.constraint(equalToConstant: 100),
            starView.heightAnchor.constraint(equalToConstant: 100),
        ])      
    }

    private func createBaseView(backgroundColor: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    private func createRoundView(backgroundColor: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 40
        return view
    }

    private func createTrapezoidView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 30, y: 0))
        path.addLine(to: CGPoint(x: 90, y: 0))
        path.addLine(to: CGPoint(x: 120, y: 100))
        path.addLine(to: CGPoint(x: 0, y: 100))
        path.close()

        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.systemPink.withAlphaComponent(0.5).cgColor
        view.layer.addSublayer(shapeLayer)

        return view
    }

    private func createTriangleView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 50, y: 0))
        path.addLine(to: CGPoint(x: 100, y: 100))
        path.addLine(to: CGPoint(x: 0, y: 100))
        path.close()

        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.cyan.withAlphaComponent(0.5).cgColor
        view.layer.addSublayer(shapeLayer)

        return view
    }

    private func createOverlayContainer() -> UIView {
        let container = UIView()
        container.backgroundColor = .clear
        container.translatesAutoresizingMaskIntoConstraints = false

        // Create subviews for overlay
        let interactiveView = UIView()
        interactiveView.backgroundColor = .clear
        interactiveView.translatesAutoresizingMaskIntoConstraints = false
        interactiveView.isUserInteractionEnabled = true

        let nonInteractiveView1 = UIView()
        nonInteractiveView1.backgroundColor = .clear
        nonInteractiveView1.translatesAutoresizingMaskIntoConstraints = false
        nonInteractiveView1.isUserInteractionEnabled = false

        let nonInteractiveView2 = UIView()
        nonInteractiveView2.backgroundColor = .clear
        nonInteractiveView2.translatesAutoresizingMaskIntoConstraints = false
        nonInteractiveView2.isUserInteractionEnabled = false

        // Add subviews to container
        container.addSubview(interactiveView)
        container.addSubview(nonInteractiveView1)
        container.addSubview(nonInteractiveView2)

        // Setup constraints for overlay subviews
        NSLayoutConstraint.activate([
            interactiveView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            interactiveView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            interactiveView.widthAnchor.constraint(equalToConstant: 150),
            interactiveView.heightAnchor.constraint(equalToConstant: 150),

            nonInteractiveView1.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            nonInteractiveView1.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            nonInteractiveView1.widthAnchor.constraint(equalToConstant: 100),
            nonInteractiveView1.heightAnchor.constraint(equalToConstant: 100),

            nonInteractiveView2.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            nonInteractiveView2.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            nonInteractiveView2.widthAnchor.constraint(equalToConstant: 100),
            nonInteractiveView2.heightAnchor.constraint(equalToConstant: 100),
        ])

        return container
    }

    private func createDiagonalStripesView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()

        for i in stride(from: 0, to: 200, by: 20) {
            path.move(to: CGPoint(x: 0, y: CGFloat(i)))
            path.addLine(to: CGPoint(x: CGFloat(i), y: 0))
        }

        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.purple.withAlphaComponent(0.3).cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.fillColor = nil
        view.layer.addSublayer(shapeLayer)

        return view
    }

    private func createCurvedView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()

        path.move(to: CGPoint(x: 0, y: 50))
        path.addCurve(to: CGPoint(x: 100, y: 50),
                      controlPoint1: CGPoint(x: 30, y: 0),
                      controlPoint2: CGPoint(x: 70, y: 100))

        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.systemGreen.withAlphaComponent(0.4).cgColor
        shapeLayer.lineWidth = 15
        shapeLayer.fillColor = nil
        view.layer.addSublayer(shapeLayer)

        return view
    }

    private func createRandomSquaresView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        for _ in 0 ..< 5 {
            let squareView = UIView()
            squareView.translatesAutoresizingMaskIntoConstraints = false
            squareView.backgroundColor = [UIColor.yellow, UIColor.blue, UIColor.red, UIColor.green, UIColor.purple]
                .randomElement()?.withAlphaComponent(0.3)
            squareView.transform = CGAffineTransform(rotationAngle: .random(in: 0 ... (.pi / 4)))
            view.addSubview(squareView)

            NSLayoutConstraint.activate([
                squareView.widthAnchor.constraint(equalToConstant: .random(in: 20 ... 50)),
                squareView.heightAnchor.constraint(equalToConstant: .random(in: 20 ... 50)),
                squareView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: .random(in: -50 ... 50)),
                squareView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: .random(in: -50 ... 50)),
            ])
        }

        return view
    }

    private func createWavePatternView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()

        // Create wave pattern
        var x: CGFloat = 0
        while x < 150 {
            path.move(to: CGPoint(x: x, y: 0))
            path.addCurve(
                to: CGPoint(x: x + 50, y: 0),
                controlPoint1: CGPoint(x: x + 25, y: -20),
                controlPoint2: CGPoint(x: x + 25, y: 20)
            )
            x += 50
        }

        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.systemTeal.withAlphaComponent(0.4).cgColor
        shapeLayer.lineWidth = 8
        shapeLayer.fillColor = nil
        view.layer.addSublayer(shapeLayer)

        return view
    }

    private func createConcentricCirclesView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()

        for radius in stride(from: 10, through: 50, by: 10) {
            path.addArc(
                withCenter: CGPoint(x: 50, y: 50),
                radius: CGFloat(radius),
                startAngle: 0,
                endAngle: 2 * .pi,
                clockwise: true
            )
        }

        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.systemPink.withAlphaComponent(0.3).cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.fillColor = nil
        view.layer.addSublayer(shapeLayer)

        return view
    }

    private func createMosaicView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        for row in 0 ... 4 {
            for col in 0 ... 4 {
                let smallView = UIView()
                smallView.translatesAutoresizingMaskIntoConstraints = false
                smallView.backgroundColor = [UIColor.systemOrange, .systemBlue, .systemGreen, .systemPurple, .systemPink]
                    .randomElement()?.withAlphaComponent(0.2)
                smallView.transform = CGAffineTransform(rotationAngle: .random(in: 0 ... (.pi / 6)))
                view.addSubview(smallView)

                NSLayoutConstraint.activate([
                    smallView.widthAnchor.constraint(equalToConstant: 15),
                    smallView.heightAnchor.constraint(equalToConstant: 15),
                    smallView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(col * 20)),
                    smallView.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(row * 20)),
                ])
            }
        }

        return view
    }

    private func createSpiralView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()

        var angle: CGFloat = 0
        var radius: CGFloat = 0
        let center = CGPoint(x: 100, y: 100)

        while radius < 80 {
            let x = center.x + radius * cos(angle)
            let y = center.y + radius * sin(angle)

            if radius == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }

            angle += 0.2
            radius += 0.5
        }

        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.systemIndigo.withAlphaComponent(0.4).cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.fillColor = nil
        view.layer.addSublayer(shapeLayer)

        return view
    }

    private func createBlobsView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        for _ in 0 ... 5 {
            let blobLayer = CAShapeLayer()
            let path = UIBezierPath()

            let centerX = CGFloat.random(in: 30 ... 120)
            let centerY = CGFloat.random(in: 30 ... 120)

            path.addArc(
                withCenter: CGPoint(x: centerX, y: centerY),
                radius: CGFloat.random(in: 15 ... 35),
                startAngle: 0,
                endAngle: 2 * .pi,
                clockwise: true
            )

            blobLayer.path = path.cgPath
            blobLayer.fillColor = [UIColor.systemPink, .systemTeal, .systemGreen, .systemOrange]
                .randomElement()?.withAlphaComponent(0.3).cgColor
            view.layer.addSublayer(blobLayer)
        }

        return view
    }

    private func createDotsPatternView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        for row in 0 ... 6 {
            for col in 0 ... 6 {
                let dotView = UIView()
                dotView.translatesAutoresizingMaskIntoConstraints = false
                dotView.backgroundColor = [UIColor.systemBlue, .systemRed, .systemYellow]
                    .randomElement()?.withAlphaComponent(0.4)
                dotView.layer.cornerRadius = 5
                view.addSubview(dotView)

                NSLayoutConstraint.activate([
                    dotView.widthAnchor.constraint(equalToConstant: 10),
                    dotView.heightAnchor.constraint(equalToConstant: 10),
                    dotView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(col * 25)),
                    dotView.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(row * 25)),
                ])
            }
        }

        return view
    }

    private func createColorfulSquaresView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let colors: [UIColor] = [.systemRed, .systemBlue, .systemGreen, .systemYellow]
        for (index, color) in colors.enumerated() {
            let square = UIView()
            square.backgroundColor = color
            square.translatesAutoresizingMaskIntoConstraints = false
            square.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 6)
            view.addSubview(square)

            NSLayoutConstraint.activate([
                square.widthAnchor.constraint(equalToConstant: 50),
                square.heightAnchor.constraint(equalToConstant: 50),
                square.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: CGFloat(index * 20)),
                square.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: CGFloat(index * 20)),
            ])
        }
        return view
    }

    private func createDiamondView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()

        path.move(to: CGPoint(x: 50, y: 0))
        path.addLine(to: CGPoint(x: 100, y: 50))
        path.addLine(to: CGPoint(x: 50, y: 100))
        path.addLine(to: CGPoint(x: 0, y: 50))
        path.close()

        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.systemPurple.cgColor // Solid color
        view.layer.addSublayer(shapeLayer)

        return view
    }

    private func createStarView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        let center = CGPoint(x: 50, y: 50)
        let points = 5
        let radius: CGFloat = 50
        let innerRadius: CGFloat = 25

        let angleIncrement = CGFloat.pi * 2 / CGFloat(points)
        var angle = -CGFloat.pi / 2

        path.move(to: CGPoint(x: center.x + radius * cos(angle),
                              y: center.y + radius * sin(angle)))

        for _ in 0 ..< points {
            angle += angleIncrement / 2
            path.addLine(to: CGPoint(x: center.x + innerRadius * cos(angle),
                                     y: center.y + innerRadius * sin(angle)))
            angle += angleIncrement / 2
            path.addLine(to: CGPoint(x: center.x + radius * cos(angle),
                                     y: center.y + radius * sin(angle)))
        }
        path.close()

        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.systemOrange.cgColor // Solid color
        view.layer.addSublayer(shapeLayer)

        return view
    }
}
