import { Controller, Get, Param } from '@nestjs/common';
import { TheoryService, Category, Word, WordDetail } from './theory.service';

@Controller('theory')
export class TheoryController {
  constructor(private readonly theoryService: TheoryService) {}

  @Get('categories')
  getCategories(): Category[] {
    return this.theoryService.getCategories();
  }

  @Get('categories/:id/words')
  getWordsByCategory(@Param('id') id: string): Word[] {
    return this.theoryService.getWordsByCategory(id);
  }

  @Get('words/:id')
  getWordDetail(@Param('id') id: string): WordDetail | undefined {
    return this.theoryService.getWordDetail(id);
  }
}