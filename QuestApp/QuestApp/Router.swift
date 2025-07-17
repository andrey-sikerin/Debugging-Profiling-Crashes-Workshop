// # Copyright 2025 Yandex LLC. All rights reserved.

import UIKit

#if USE_QUESTCORE_FRAMEWORK

    import QuestCore

#endif

final class Router {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func goToStep(_ step: Step) {
        let (identifier, sender) = { () -> (String, Any) in
            switch step {
            case let .crashSomeWhere(findModel):
                return ("findSome", findModel)
            case let .greeting(greetingModel):
                return ("showGreeting", greetingModel)
            case let .locker(lockerModel):
                return ("showLocker", lockerModel)
            case let .bingo(bingoModel):
                return ("showBingo", bingoModel)
            case let .viewHieratriy(viewHierachyModel):
                return ("showViewHierarchy", viewHierachyModel)
            case let .passwordLock(passwordLockModel):
                return ("showPasswordLock", passwordLockModel)
            case let .memoryLeak(memoryLeakModel):
                return ("ShowMemory", memoryLeakModel)
            @unknown default:
                logger.error("Undefined transition")
                fatalError()
            }
        }()

        navigationController.performSegue(
            withIdentifier: identifier,
            sender: sender
        )
    }
}
