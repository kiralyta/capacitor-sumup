export interface CheckoutOptions {
  amount: number;
  currencyCode?: string | null;
  title?: string | null;
  foreignTransactionID?: string | null;
  tipAmount?: number | null;
}

export interface CheckoutResult {
  transactionCode: string;
  additionalInfo: { [key: string]: any };
}

export interface SumUpPlugin {
  wakeUp(): Promise<void>;
  initialize(options: { affiliateKey: string }): Promise<void>;
  login(options: { accessToken: string }): Promise<void>;
  checkout(options: CheckoutOptions): Promise<CheckoutResult>;
}
