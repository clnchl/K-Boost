import { Controller, Get, Param } from '@nestjs/common';
import { Category, Word, WordDetail } from '@prisma/client';
import { TheoryService } from './theory.service';

// Ce controller expose les routes HTTP pour accéder aux données de théorie
// Toutes les routes commencent par /theory
@Controller('theory')
export class TheoryController {
  constructor(private readonly theoryService: TheoryService) {}

  // Récupère toutes les catégories depuis le service
  @Get('categories')
  async getCategories(): Promise<Category[]> {
    return this.theoryService.getCategories();
  }

  // Récupère tous les mots d'une catégorie spécifique
  @Get('categories/:id/words')
  async getWordsByCategory(@Param('id') id: string): Promise<Word[]> {
    return this.theoryService.getWordsByCategory(id);
  }

  // Récupère le détail complet d'un mot spécifique 
  @Get('words/:id')
  async getWordDetail(@Param('id') id: string): Promise<WordDetail> {
    return this.theoryService.getWordDetail(id);
  }
}