// main.js

import App from './App.svelte';

import { AgonesSDK } from '@google-cloud/agones-sdk';

export async function initializeAgonesSDK() {
  const sdk = new AgonesSDK();

  try {
    console.log('Connecting to Agones SDK...');
    await sdk.connect();
    console.log('Connection to Agones SDK successful');
    await sdk.ready();
    console.log('Ready  signal sent');
    await sdk.health();
    console.log('Health check called successfully');
    // Other initialization steps (e.g., setting labels, annotations, signaling readiness) here...
  } catch (error) {
    console.error('Error connecting to Agones SDK:', error);
  }
}

const app = new App({
	target: document.body,
	props: {}
});

export default app;