export interface SumUpPlugin {

  /**
   * Login to a SumUp account.
   */
  login(options: LoginOptions): Promise<void>;

  /**
   * Make a payment on a card reader. Everything is handled by the internal SDKs.
   */
  checkout(options: CheckoutOptions): Promise<CheckoutResult>;

  /**
   * Prepare the connected card reader for a possible upcoming checkout.
   */
  wakeUp(): Promise<void>;
}

export interface LoginOptions {

  /**
     * Affiliate key generated on the SumUp dev portal
     */
  affiliateKey: string,

  /**
   * Access token retrieved from SumUp API
   */
  accessToken: string
}

export interface CheckoutResult {

  /**
   * Unique SumUp transaction ID of successful payment
   */
  transactionCode: string;

  /**
   * Additional infos returned by the SDKs
   */
  additionalInfo: { [key: string]: any };
}

export interface CheckoutOptions {

  /**
   * Amount to be charged
   */
  amount: number;

  /**
   * ISO 4217 currency code. Defaults to HUF
   */
  currencyCode?: string | null;

  /**
   * Message to be shown on specific card readers. Defaults to "Time to Pay"
   */
  title?: string | null;

  /**
   * Unique ID of the transaction on client side (optional)
   */
  foreignTransactionID?: string | null;

  /**
   * Amount to tip, works only on specific card readers
   */
  tipAmount?: number | null;

  /**
   * Whether to skip the receipt screen on successful payment
   */
  skipReceiptScreen?: boolean | null;
}
