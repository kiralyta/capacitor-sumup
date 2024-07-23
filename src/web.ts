import { WebPlugin } from '@capacitor/core';

import type { SumUpPlugin } from './definitions';

export class SumUpWeb extends WebPlugin implements SumUpPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('fdafdaf', options);
    return options;
  }

  async initialize(_options: { affiliateKey: string }): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async login(_options: { accessToken: string }): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }
}
