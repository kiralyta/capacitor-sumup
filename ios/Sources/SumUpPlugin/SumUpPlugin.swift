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
        CAPPluginMethod(name: "login", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "checkout", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "wakeUp", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "logout", returnType: CAPPluginReturnPromise)
    ]

    @objc func login(_ call: CAPPluginCall) {
        let affiliateKey = call.getString("affiliateKey") ?? ""
        let accessToken = call.getString("accessToken") ?? ""

        SumUpSDK.setup(withAPIKey: affiliateKey)

        SumUpSDK.login(withToken: accessToken) { success, error in
            if success {
                call.resolve()
            } else {
                call.reject(error?.localizedDescription ?? "Unknown error")
            }
        }
    }

    @objc func checkout(_ call: CAPPluginCall) {
        guard let amount = call.getDouble("amount") else {
            call.reject("Amount is required")
            return
        }
        let currencyCode = call.getString("currencyCode") ?? "HUF"
        let title = call.getString("title") ?? "Time to Pay"
        let foreignTransactionID = call.getString("foreignTransactionID") ?? ""
        let tipAmount = call.getDouble("tipAmount") ?? 0.00
        let skipReceiptScreen = call.getBool("skipReceiptScreen") ?? true

        // setup payment request
        let request = CheckoutRequest(total: NSDecimalNumber(value: amount),
                                      title: title,
                                      currencyCode: currencyCode)

        // Set Tip Amount
        request.tipAmount = NSDecimalNumber(value: tipAmount)

        // Set Foreign Transaction ID
        request.foreignTransactionID = foreignTransactionID

        // Set Skip Receipt Screen
        if skipReceiptScreen {
            request.skipScreenOptions = .success
        }

        // Obtain the current view controller
        guard let viewController = bridge?.viewController else {
            call.reject("No view controller available")
            return
        }

        SumUpSDK.checkout(with: request, from: viewController) { [weak self] (result: CheckoutResult?, error: Error?) in
            if let safeError = error as NSError? {
                call.reject("error during checkout: \(safeError)")

                if (safeError.domain == SumUpSDKErrorDomain) && (safeError.code == SumUpSDKError.accountNotLoggedIn.rawValue) {
                    call.reject("not logged in")
                } else {
                    call.reject("general error")
                }

                return
            }

            guard let safeResult = result else {
                call.reject("no error and no result should not happen")
                return
            }

            if safeResult.success {
                call.resolve([
                    "transactionCode": safeResult.transactionCode ?? "",
                    "additionalInfo": safeResult.additionalInfo ?? [:]
                ])
            } else {
                call.reject("No charge (cancelled)")
            }
        }

        // after the checkout is initiated we expect a checkout to be in progress
        if !SumUpSDK.checkoutInProgress {
            // something went wrong: checkout was not started
            call.reject("Checkout failed")
        }
    }

    @objc func wakeUp(_ call: CAPPluginCall) {
        SumUpSDK.prepareForCheckout()
    }

    @objc func logout(_ call: CAPPluginCall) {
        SumUpSDK.logout()
    }
}
