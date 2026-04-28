import { Module } from '@nestjs/common';
import { TheoryController } from './theory.controller';
import { TheoryService } from './theory.service';

// Ce module regrouppe le controller et le service de théorie
@Module({
  controllers: [TheoryController],
  providers: [TheoryService]
})
export class TheoryModule {}
