import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHome() {
    return {
      name: 'K-Boost API',
      status: 'online',
      version: '1.0.0',
    };
  }
}
