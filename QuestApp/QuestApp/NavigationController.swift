// # Copyright 2025 Yandex LLC. All rights reserved.

import UIKit

#if USE_QUESTCORE_FRAMEWORK

    import QuestCore

    let questCurrentStep = startStep

#else

    let questCurrentStep = QuestContoller.shared.currentStep /// quest//QuestContoller.shared.currentStep

#endif

final class NavigationController: UINavigationController {
    private lazy var router = Router(navigationController: self)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        router.goToStep(questCurrentStep)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.destination, sender) {
        case let (findSomeVC as CrashSomewhereViewController, model as CrashSomeWhereModel):
            findSomeVC.model = model
            findSomeVC.router = router
        case let (greetingVC as GreetingViewController, model as GreetingModel):
            greetingVC.router = router
            greetingVC.model = model
        case let (lockerVC as LockerViewController, model as LockerModel):
            lockerVC.router = router
            lockerVC.model = model
        case let (bingoVC as BingoViewController, model as BingoModel):
            bingoVC.router = router
            bingoVC.model = model
        case let (vhVC as ViewHierarchyViewController, model as ViewHierarchyModel):
            vhVC.model = model
            model.goToNext = { [unowned self] in router.goToStep($0) }
        case let (passwordVC as PasswordLockScreenViewController, model as PasswordLockModel):
            passwordVC.model = model
            model.goToNext = { [unowned self] in router.goToStep($0) }
        case let (memoryLeaksVC as MemoryLeakViewController, model as MemoryLeakModel):
            memoryLeaksVC.model = model
            model.goToNext = { [unowned self] in router.goToStep($0) }
        default:
            assertionFailure()
        }
    }
}
