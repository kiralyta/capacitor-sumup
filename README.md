# capacitor-sumup

A Capacitor.js bridge to SumUp native SDKs

## Install

```bash
npm install capacitor-sumup
npx cap sync
```

## Update Your Info.plist file

```
NSLocationWhenInUseUsageDescription
NSBluetoothAlwaysUsageDescription
NSBluetoothPeripheralUsageDescription (unless your deployment target is at least iOS 13)
```

## API

<docgen-index>

* [`wakeUp()`](#wakeup)
* [`initialize(...)`](#initialize)
* [`login(...)`](#login)
* [`checkout(...)`](#checkout)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### wakeUp()

```typescript
wakeUp() => Promise<void>
```

--------------------


### initialize(...)

```typescript
initialize(options: { affiliateKey: string; }) => Promise<void>
```

| Param         | Type                                   |
| ------------- | -------------------------------------- |
| **`options`** | <code>{ affiliateKey: string; }</code> |

--------------------


### login(...)

```typescript
login(options: { accessToken: string; }) => Promise<void>
```

| Param         | Type                                  |
| ------------- | ------------------------------------- |
| **`options`** | <code>{ accessToken: string; }</code> |

--------------------


### checkout(...)

```typescript
checkout(options: CheckoutOptions) => Promise<CheckoutResult>
```

| Param         | Type                                                        |
| ------------- | ----------------------------------------------------------- |
| **`options`** | <code><a href="#checkoutoptions">CheckoutOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#checkoutresult">CheckoutResult</a>&gt;</code>

--------------------


### Interfaces


#### CheckoutResult

| Prop                  | Type                                 |
| --------------------- | ------------------------------------ |
| **`transactionCode`** | <code>string</code>                  |
| **`additionalInfo`**  | <code>{ [key: string]: any; }</code> |


#### CheckoutOptions

| Prop                       | Type                        |
| -------------------------- | --------------------------- |
| **`amount`**               | <code>number</code>         |
| **`currencyCode`**         | <code>string \| null</code> |
| **`title`**                | <code>string \| null</code> |
| **`foreignTransactionID`** | <code>string \| null</code> |
| **`tipAmount`**            | <code>number \| null</code> |

</docgen-api>
