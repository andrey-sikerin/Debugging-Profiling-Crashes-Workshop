// # Copyright 2025 Yandex LLC. All rights reserved.

import UIKit

#if USE_QUESTCORE_FRAMEWORK

    import QuestCore

#endif

final class BingoViewController: UIViewController {
    var model: BingoModel!
    var router: Router!
    private let confetti: ConfettiView = .top

    override func viewDidLoad() {
        super.viewDidLoad()

        confetti.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(confetti)
        NSLayoutConstraint.activate([
            confetti.topAnchor.constraint(equalTo: view.topAnchor),
            confetti.rightAnchor.constraint(equalTo: view.rightAnchor),
            confetti.leftAnchor.constraint(equalTo: view.leftAnchor),
        ])
    }

    @IBOutlet var codeLabel: UILabel!

    @IBAction func onGetCode() {
        model.getBingoCode { [weak self] code in
            DispatchQueue.main.async {
                self?.codeLabel.text = code
                self?.confetti.emit()
            }
        }
    }
}
