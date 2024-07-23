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

* [`echo(...)`](#echo)
* [`initialize(...)`](#initialize)
* [`login(...)`](#login)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

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

</docgen-api>
