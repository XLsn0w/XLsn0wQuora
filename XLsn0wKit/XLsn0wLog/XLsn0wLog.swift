
import UIKit

public func XLsn0wLog<T>(printObject: T,
                           printFile: String = #file,
                           printLine: Int    = #line,
                       printFunction: String = #function,
                          printFalse: Bool   = false) {
    if printFalse {
        print("©XLsn0wLog© \n file: \((printFile as NSString).lastPathComponent) \n line: \(printLine) \n func: \(printFunction) \n---print---\n\(printObject) \n---print---\n©XLsn0wLog©\n")
    } else {
        #if DEBUG
        print("©XLsn0wLog© \n file: \((printFile as NSString).lastPathComponent) \n line: \(printLine) \n func: \(printFunction) \n---print---\n\(printObject) \n---print---\n©XLsn0wLog©\n")
        #endif
    }
}
