export interface SumUpPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  initialize(options: { affiliateKey: string }): Promise<void>;
  login(options: { accessToken: string }): Promise<void>;
}
