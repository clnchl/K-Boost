import { Controller, Get, Param } from '@nestjs/common';
import { TheoryService, Category, Word, WordDetail } from './theory.service';

// Ce controller expose les routes HTTP pour accéder aux données de théorie
// Toutes les routes commencent par /theory
@Controller('theory')
export class TheoryController {
  constructor(private readonly theoryService: TheoryService) {}

  // Récupère toutes les catégories depuis le service
  @Get('categories')
  getCategories(): Category[] {
    return this.theoryService.getCategories();
  }

  // Récupère tous les mots d'une catégorie spécifique
  @Get('categories/:id/words')
  getWordsByCategory(@Param('id') id: string): Word[] {
    return this.theoryService.getWordsByCategory(id);
  }

  // Récupère le détail complet d'un mot spécifique 
  @Get('words/:id')
  getWordDetail(@Param('id') id: string): WordDetail | undefined {
    return this.theoryService.getWordDetail(id);
  }
}