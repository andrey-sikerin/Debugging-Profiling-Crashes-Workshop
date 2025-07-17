// # Copyright 2025 Yandex LLC. All rights reserved.

import SwiftUI
import UIKit

#if USE_QUESTCORE_FRAMEWORK

    import QuestCore

#endif

final class CrashSomewhereViewController: UIViewController {
    var model: CrashSomeWhereModel!
    var router: Router!

    @IBOutlet var answerField: UITextField!
    @IBOutlet var conditions: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let condition = model.condition else { return }
        let l = condition.compactMap { $0 }.compactMap { $0 }
        conditions.text = l.joined(separator: "\n")
        conditions.isEditable = false
    }

    @IBAction func onCheckAnswer() {
        let answer = answerField.text ?? ""
        let result = model.checkAnswer(answer)
        switch result {
        case let .success(nextStep):
            router.goToStep(nextStep)
        case let .failure(error):
            logger.error("[CrashSomeWhereViewController] \(error.localizedDescription)")
        }
    }
}
