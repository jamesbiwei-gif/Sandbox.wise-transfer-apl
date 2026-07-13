# Wise Transfer API Demo

A comprehensive demo application showcasing the Wise Transfer API functionality.

## Overview

This repository demonstrates how to interact with the Wise Transfer API for:
- Account management
- Balance inquiries
- Exchange rates
- Recipient management
- Transfer creation and tracking
- Quote retrieval

## Getting Started

### Prerequisites
- Node.js (v14 or higher)
- npm or yarn
- Wise Transfer API key

### Installation

```bash
npm install
```

### Configuration

Create a `.env` file with your Wise Transfer API credentials:

```
WISE_API_KEY=your_api_key_here
WISE_API_BASE_URL=https://api.sandbox.transferwise.tech
```

### Building

```bash
npm run build
```

### Development

```bash
npm run dev
```

### Testing

```bash
npm test
```

## API Reference

### Account Operations

```typescript
// Get account information
const account = await demo.getAccount();

// Get account balance
const balance = await demo.getBalance();
```

### Exchange Rates

```typescript
// Get exchange rate
const rate = await demo.getExchangeRate('USD', 'EUR');

// Get quote with amount
const quote = await demo.getQuote('USD', 'EUR', 1000);
```

### Recipients

```typescript
// Create recipient
const recipient = await demo.createRecipient({
  name: 'John Doe',
  country: 'US',
  accountNumber: '123456789',
  bankCode: 'BANK123'
});

// Get all recipients
const recipients = await demo.getRecipients();
```

### Transfers

```typescript
// Create transfer
const transfer = await demo.createTransfer(
  recipientId,
  1000,
  'USD',
  'EUR'
);

// Get transfer status
const status = await demo.getTransfer(transferId);

// Get all transfers
const transfers = await demo.getTransfers();

// Cancel transfer
await demo.cancelTransfer(transferId);
```

## Features

- ✅ Full TypeScript support
- ✅ Comprehensive error handling
- ✅ Exchange rate queries
- ✅ Transfer quote system
- ✅ Recipient management
- ✅ Transfer tracking
- ✅ Unit tests included
- ✅ Sandbox environment ready

## License

MIT
