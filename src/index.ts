/**
 * Wise Transfer API Sandbox
 * Main entry point for the sandbox environment
 */

import axios, { AxiosInstance } from 'axios';

interface TransferConfig {
  apiKey: string;
  baseUrl: string;
}

class WiseTransferSandbox {
  private client: AxiosInstance;
  private config: TransferConfig;

  constructor(config: TransferConfig) {
    this.config = config;
    this.client = axios.create({
      baseURL: config.baseUrl,
      headers: {
        'Authorization': `Bearer ${config.apiKey}`,
        'Content-Type': 'application/json',
      },
    });
  }

  /**
   * Get account information
   */
  async getAccount(): Promise<any> {
    try {
      const response = await this.client.get('/account');
      return response.data;
    } catch (error) {
      console.error('Error fetching account:', error);
      throw error;
    }
  }

  /**
   * Create a transfer
   */
  async createTransfer(data: any): Promise<any> {
    try {
      const response = await this.client.post('/transfers', data);
      return response.data;
    } catch (error) {
      console.error('Error creating transfer:', error);
      throw error;
    }
  }

  /**
   * Get transfer status
   */
  async getTransfer(transferId: string): Promise<any> {
    try {
      const response = await this.client.get(`/transfers/${transferId}`);
      return response.data;
    } catch (error) {
      console.error('Error fetching transfer:', error);
      throw error;
    }
  }
}

export default WiseTransferSandbox;
