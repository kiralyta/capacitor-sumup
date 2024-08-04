import { WebPlugin } from '@capacitor/core';

import type { CheckoutOptions, CheckoutResult, LoginOptions, SumUpPlugin } from './definitions';

export class SumUpWeb extends WebPlugin implements SumUpPlugin {

  async login(_options: LoginOptions): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async checkout(_options: CheckoutOptions): Promise<CheckoutResult> {
    throw this.unimplemented('Not implemented on web.');
  }

  async wakeUp(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async logout(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }
}
