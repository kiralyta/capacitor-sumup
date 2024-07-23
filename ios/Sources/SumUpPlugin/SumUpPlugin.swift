import Foundation
import Capacitor
import SumUpSDK

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(SumUpPlugin)
public class SumUpPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "SumUpPlugin"
    public let jsName = "SumUp"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "initialize", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "login", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = SumUp()

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }

    @objc func initialize(_ call: CAPPluginCall) {
        let affiliateKey = call.getString("affiliateKey") ?? ""
        call.resolve([
            "affiliateKey": implementation.echo(affiliateKey)
        ])
    }

    @objc func login(_ call: CAPPluginCall) {
        let accessToken = call.getString("accessToken") ?? ""

        SumUpSDK.login(withToken: accessToken) { success, error in
            if success {
                call.resolve()
            } else {
                call.reject(error?.localizedDescription ?? "Unknown error")
            }
        }
    }
}
