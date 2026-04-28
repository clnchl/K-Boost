import { Module } from '@nestjs/common';
import { TheoryController } from './theory.controller';
import { TheoryService } from './theory.service';

@Module({
  controllers: [TheoryController],
  providers: [TheoryService]
})
export class TheoryModule {}
