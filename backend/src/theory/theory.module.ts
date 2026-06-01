import { Module } from '@nestjs/common';
import { PrismaModule } from '../prisma/prisma.module';
import { TheoryController } from './theory.controller';
import { TheoryService } from './theory.service';

// Ce module regrouppe le controller et le service de théorie
@Module({
  imports: [PrismaModule],
  controllers: [TheoryController],
  providers: [TheoryService]
})
export class TheoryModule {}
