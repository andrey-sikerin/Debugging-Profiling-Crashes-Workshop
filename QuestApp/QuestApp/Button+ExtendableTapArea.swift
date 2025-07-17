// # Copyright 2025 Yandex LLC. All rights reserved.

import UIKit

final class ButtonWithExtendableTapArea: UIButton {
    override func point(inside point: CGPoint, with _: UIEvent?) -> Bool {
        let extendedFrame = bounds.inset(by: extendInsets)
        return extendedFrame.contains(point)
    }
}

private extension UIEdgeInsets {
    init(
        horizontal: CGFloat,
        vertical: CGFloat
    ) {
        self.init(
            top: vertical,
            left: horizontal,
            bottom: vertical,
            right: horizontal
        )
    }
}

private var extendInsets = UIEdgeInsets(horizontal: 1, vertical: 1)
