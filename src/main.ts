import { WiseTransferDemo } from './index';

// Initialize the demo
const config = {
  apiKey: process.env.WISE_API_KEY || 'your_api_key_here',
  baseUrl: process.env.WISE_API_BASE_URL || 'https://api.sandbox.transferwise.tech',
};

const demo = new WiseTransferDemo(config);

// Export for use in other modules
export default demo;
