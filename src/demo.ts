import { WiseTransferDemo } from './index';

/**
 * Demo example usage of WiseTransferDemo
 */
async function runDemo() {
  const config = {
    apiKey: process.env.WISE_API_KEY || 'your_api_key_here',
    baseUrl: process.env.WISE_API_BASE_URL || 'https://api.sandbox.transferwise.tech',
  };

  const demo = new WiseTransferDemo(config);

  try {
    console.log('=== Wise Transfer API Demo ===\n');

    // 1. Get account information
    console.log('1. Fetching account information...');
    const account = await demo.getAccount();
    console.log('Account:', account);
    console.log();

    // 2. Get balance
    console.log('2. Fetching account balance...');
    const balance = await demo.getBalance();
    console.log('Balance:', balance);
    console.log();

    // 3. Get exchange rate
    console.log('3. Fetching exchange rate (USD to EUR)...');
    const rate = await demo.getExchangeRate('USD', 'EUR');
    console.log('Exchange Rate:', rate);
    console.log();

    // 4. Get transfer quote
    console.log('4. Getting transfer quote for $1000 USD to EUR...');
    const quote = await demo.getQuote('USD', 'EUR', 1000);
    console.log('Quote:', quote);
    console.log();

    // 5. Get recipients
    console.log('5. Fetching recipients...');
    const recipients = await demo.getRecipients();
    console.log('Recipients:', recipients);
    console.log();

    // 6. Get transfers
    console.log('6. Fetching all transfers...');
    const transfers = await demo.getTransfers();
    console.log('Transfers:', transfers);
    console.log();

    console.log('Demo completed successfully!');
  } catch (error) {
    console.error('Error running demo:', error);
  }
}

// Run the demo
runDemo();
