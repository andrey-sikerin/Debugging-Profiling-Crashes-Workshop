// # Copyright 2025 Yandex LLC. All rights reserved.

import UIKit

#if USE_QUESTCORE_FRAMEWORK

    import QuestCore

#endif

final class GreetingViewController: UIViewController {
    var model: GreetingModel!
    var router: Router!

    @IBAction func onStart() {
        router.goToStep(model.nextStep())
    }
}
