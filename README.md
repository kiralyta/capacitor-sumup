# Capacitor.js SumUp plugin

A Capacitor.js bridge to SumUp native SDKs.

## Install

```bash
npm install capacitor-sumup
npx cap sync
```

Import it into your project and enjoy the ride.

```javascript
import { SumUp } from 'capacitor-sumup'

await SumUp.login({
    affiliateKey: 'YOUR-AFFILIATE-KEY',
    accessToken: 'YOUR-ACCESS-TOKEN'
})
```

## Setup

### iOS (update your Info.plist file)
```
NSLocationWhenInUseUsageDescription
NSBluetoothAlwaysUsageDescription
NSBluetoothPeripheralUsageDescription (unless your deployment target is at least iOS 13)
```

### Android

Add the repository to your gradle dependencies (to your root build.gradle file)

```
allprojects {
   repositories {
      maven { url 'https://maven.sumup.com/releases' }
   }
}
```

Add the dependency to a module (to your module's build.gradle file)

```
implementation 'com.sumup:merchant-sdk:5.0.1'
```

> Also, the minSdkVersion must be at least 26 in your Capacitor.js project.

## API

<docgen-index>

* [`login(...)`](#login)
* [`checkout(...)`](#checkout)
* [`wakeUp()`](#wakeup)
* [`logout()`](#logout)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### login(...)

```typescript
login(options: LoginOptions) => Promise<void>
```

Login to a SumUp account.

| Param         | Type                                                  |
| ------------- | ----------------------------------------------------- |
| **`options`** | <code><a href="#loginoptions">LoginOptions</a></code> |

--------------------


### checkout(...)

```typescript
checkout(options: CheckoutOptions) => Promise<CheckoutResult>
```

Make a payment on a card reader. Everything is handled by the internal SDKs.

| Param         | Type                                                        |
| ------------- | ----------------------------------------------------------- |
| **`options`** | <code><a href="#checkoutoptions">CheckoutOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#checkoutresult">CheckoutResult</a>&gt;</code>

--------------------


### wakeUp()

```typescript
wakeUp() => Promise<void>
```

Prepare the connected card reader for a possible upcoming checkout.

--------------------


### logout()

```typescript
logout() => Promise<void>
```

Disconnect and logout.

--------------------


### Interfaces


#### LoginOptions

| Prop               | Type                | Description                                     |
| ------------------ | ------------------- | ----------------------------------------------- |
| **`affiliateKey`** | <code>string</code> | Affiliate key generated on the SumUp dev portal |
| **`accessToken`**  | <code>string</code> | Access token retrieved from SumUp API           |


#### CheckoutResult

| Prop                  | Type                                 | Description                                       |
| --------------------- | ------------------------------------ | ------------------------------------------------- |
| **`transactionCode`** | <code>string</code>                  | Unique SumUp transaction ID of successful payment |
| **`additionalInfo`**  | <code>{ [key: string]: any; }</code> | Additional infos returned by the SDKs             |


#### CheckoutOptions

| Prop                       | Type                         | Description                                                             |
| -------------------------- | ---------------------------- | ----------------------------------------------------------------------- |
| **`amount`**               | <code>number</code>          | Amount to be charged                                                    |
| **`currencyCode`**         | <code>string \| null</code>  | ISO 4217 currency code. Defaults to HUF                                 |
| **`title`**                | <code>string \| null</code>  | Message to be shown on specific card readers. Defaults to "Time to Pay" |
| **`foreignTransactionID`** | <code>string \| null</code>  | Unique ID of the transaction on client side (optional)                  |
| **`tipAmount`**            | <code>number \| null</code>  | Amount to tip, works only on specific card readers                      |
| **`skipReceiptScreen`**    | <code>boolean \| null</code> | Whether to skip the receipt screen on successful payment                |

</docgen-api>
