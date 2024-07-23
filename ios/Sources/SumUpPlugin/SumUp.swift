import Foundation
import SumUpSDK

@objc public class SumUp: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }

    @objc public func initialize(_ affiliateKey: String) {
        SumUpSDK.setup(withAPIKey: affiliateKey)
    }
}
