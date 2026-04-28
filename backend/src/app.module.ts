import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TheoryModule } from './theory/theory.module';

@Module({
  imports: [TheoryModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
