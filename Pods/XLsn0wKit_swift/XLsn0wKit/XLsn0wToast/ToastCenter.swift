/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
import UIKit

open class ToastCenter {

  // MARK: Properties

  private let queue: OperationQueue = {
    let queue = OperationQueue()
    queue.maxConcurrentOperationCount = 1
    return queue
  }()

  open var currentToast: XLsn0wToast? {
    return self.queue.operations.first as? XLsn0wToast
  }

  open static let `default` = ToastCenter()


  // MARK: Initializing

  init() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.deviceOrientationDidChange),
      name: .UIDeviceOrientationDidChange,
      object: nil
    )
  }


  // MARK: Adding Toasts

  open func add(_ toast: XLsn0wToast) {
    self.queue.addOperation(toast)
  }


  // MARK: Cancelling Toasts

  open func cancelAll() {
    for toast in self.queue.operations {
      toast.cancel()
    }
  }


  // MARK: Notifications

  dynamic func deviceOrientationDidChange() {
    if let lastToast = self.queue.operations.first as? XLsn0wToast {
      lastToast.view.setNeedsLayout()
    }
  }

}
