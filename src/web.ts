import { WebPlugin } from '@capacitor/core';

import type { CheckoutOptions, CheckoutResult, SumUpPlugin } from './definitions';

export class SumUpWeb extends WebPlugin implements SumUpPlugin {

  async wakeUp(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async initialize(_options: { affiliateKey: string }): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async login(_options: { accessToken: string }): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async checkout(_options: CheckoutOptions): Promise<CheckoutResult> {
    throw this.unimplemented('Not implemented on web.');
  }
}
