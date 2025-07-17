// # Copyright 2025 Yandex LLC. All rights reserved.

import UIKit

import os

#if USE_QUESTCORE_FRAMEWORK

    import QuestCore

#endif

final class LockerViewController: UIViewController {
    var model: LockerModel!
    var router: Router!
    let queue = DispatchQueue(label: "123")
    let osLog = OSLog(subsystem: "LogsDemo", category: "")
    let signpostID: OSSignpostID = .init(.random(in: 0 ..< 1_000_000))
    let name = ""
  
    @IBAction func onGoNext() {
        let startMessage = "Start: onGoNext"
        os_signpost(.begin,
                    log: osLog,
                    name: "LockerViewController",
                    signpostID: signpostID,
                    "%{public}@", startMessage)
              
        getNextStep()
      
        let endMessage = "End: onGoNext"
        os_signpost(.end,
                    log: osLog,
                    name: "LockerViewController",
                    signpostID: signpostID,
                    "%{public}@", endMessage)
    }

    func getNextStep() {
        let result = model.getNextStepOnce()
        if case let .success(step) = result {
            router.goToStep(step)
        } else if case let .failure(error) = result {
            print(error.localizedDescription)
        }
    }
}
