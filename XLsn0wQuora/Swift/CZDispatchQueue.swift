
import Foundation

/// Facade class encapsulating DispatchQueue: Limit the number of concurrently executing blocks in a dispatch queue, similar as maxConcurrentOperationCount on NSOperationQueue
///
/// Utilize DispatchSemaphore to fulfill the control of max concurrent executions.
///
open class CZDispatchQueue: NSObject {
    /// Serial queue acting as gate keeper, to ensure only one thread is blocked
    fileprivate let gateKeeperQueue: DispatchQueue
    /// Actual concurrent working queue
    fileprivate let jobQueue: DispatchQueue
    /// Max concurrent execution count
    fileprivate var maxConcurrentCount: Int
    /// Semahore to limit the max concurrent executions in dispatch queue
    fileprivate let semaphore: DispatchSemaphore

    /// Configuration constants
    fileprivate struct config {
        static let defaultmaxConcurrentCount = 64
        struct suffix {
            static let gateKeeperQueue = "gateKeeperQueue"
            static let jobQueue = "jobQueue"
        }
    }

    /// MARK: - Initializer

    public init(label: String,
                qos: DispatchQoS = .default,
                attributes: DispatchQueue.Attributes = [],
                autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = .inherit,
                target: DispatchQueue? = nil,
                maxConcurrentCount: Int) {
        /// Max concurrent block count
        self.maxConcurrentCount = maxConcurrentCount
        /// Initialize semaphore
        semaphore = DispatchSemaphore(value: maxConcurrentCount)

        /// Serial queue acting as gate keeper, to ensure only one thread is blocked
        gateKeeperQueue = DispatchQueue(label: label + config.suffix.gateKeeperQueue,
                                        qos: qos,
                                        attributes: [],
                                        autoreleaseFrequency: autoreleaseFrequency,
                                        target: target)

        /// Actual concurrent working queue
        jobQueue = DispatchQueue(label: label + config.suffix.jobQueue,
                                 qos: qos,
                                 attributes: attributes,
                                 autoreleaseFrequency: autoreleaseFrequency,
                                 target: target)
        super.init()
    }

    /// MARK: - Sync/Async Methods

    /// Asynchronization: block
    public func async(group: DispatchGroup? = nil,
        qos: DispatchQoS = .default,
        flags: DispatchWorkItemFlags = .inheritQoS,
        execute work: @escaping @convention(block) () -> Swift.Void) {
        /// Serial queue acting as gate keeper, to ensure only one thread is blocked. Otherwise all threads waiting in jobQueue are blocked.
        gateKeeperQueue.async {[weak self] in
            guard let `self` = self else {return}
            /// Actual concurrent working queue
            self.jobQueue.async {[weak self] in
                guard let `self` = self else {return}
                self.semaphore.wait()
                work()
                self.semaphore.signal()
            }
        }
    }

    /// Asynchronization: DispatchWorkItem
    public func async(execute workItem: DispatchWorkItem) {
        /// Serial queue acting as gate keeper, to ensure only one thread is blocked. Otherwise all threads waiting in jobQueue are blocked.
        gateKeeperQueue.async {[weak self] in
            guard let `self` = self else {return}
            /// Actual concurrent working queue
            self.jobQueue.async {[weak self] in
                guard let `self` = self else {return}
                self.semaphore.wait()
                workItem.perform()
                self.semaphore.signal()
            }
        }
    }

    /// Synchronization: block
    public func sync(execute work: () -> Void) {
        jobQueue.sync(execute: work)
    }

    /// Synchronization: DispatchWorkItem
    public func sync(execute workItem: DispatchWorkItem) {
        jobQueue.sync(execute: workItem)
    }
}
