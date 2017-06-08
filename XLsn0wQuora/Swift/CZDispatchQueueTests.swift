
import Foundation

class CZDispatchQueueTests: NSObject {
    enum TestMode {
        case block, workItem
    }
    /// label of dispatch queueu
    fileprivate var label = "com.jason.CZDispatchQueueDemo"
    /// Max concurrent blockCount for the queue
    fileprivate let maxConcurrentCount = 3
    /// Sleep interval for task
    fileprivate let sleepInterval = UInt32(1)
    /// Test Mode: .block, .workItem
    fileprivate let testMode: TestMode = .block

    /// Test Cases
    func test() {
        print("Begin to test .. \nmaxConcurrentCount = \(maxConcurrentCount)\n")

        // Even we triggered 1000 asynchronous tasks in CZDispatchQueue, as we set maxConcurrentCount to 3, there should have 3 concurrent executions at maximum, other tasks will be queued until slots available
        let executionCount = 1000
        switch testMode {
        case .block:
            // Test dispatch queue with execution block
            testCZDispatchQueueBlock(count: executionCount)
        case .workItem:
            // Test dispatch queue with DispatchWorkItem: should have 3 concurrent executions at maximum
            testCZDispatchQueueWorkItem(count: executionCount)
        }

    }
}

/// MARK: - Private Methods

fileprivate extension CZDispatchQueueTests {

    func testCZDispatchQueueBlock(count: Int) {
        let jobQueue = CZDispatchQueue(label: label, qos: .userInitiated, attributes: [.concurrent], maxConcurrentCount: maxConcurrentCount)

        for i in 0 ..< count {
            jobQueue.async { [weak self] in
                guard let `self` = self else {return}
                sleep(self.sleepInterval)
                print("Currently working on: \(i)")
            }
        }
    }

    func testCZDispatchQueueWorkItem(count: Int) {
        let jobQueue = CZDispatchQueue(label: label, qos: .userInitiated, attributes: [.concurrent], maxConcurrentCount: maxConcurrentCount)

        for i in 0 ..< count {
            let workItem = DispatchWorkItem(block: { [weak self] in
                guard let `self` = self else {return}
                sleep(self.sleepInterval)
                print("Currently working on: \(i)")
            })
            jobQueue.async(execute: workItem)
        }
    }
}
