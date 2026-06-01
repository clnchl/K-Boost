import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module';
import { TheoryModule } from './theory/theory.module';

@Module({
  imports: [PrismaModule, TheoryModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
