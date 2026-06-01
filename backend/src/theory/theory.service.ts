import { Injectable } from '@nestjs/common';
import { BadRequestException, NotFoundException } from '@nestjs/common';
import { Category, Word, WordDetail } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';

// Ce service gère toute la logique métier pour récupérer les données de la théorie
@Injectable()
export class TheoryService {
  constructor(private readonly prisma: PrismaService) {}

  // Retourne toutes les catégories
  async getCategories(): Promise<Category[]> {
    return this.prisma.category.findMany({
      orderBy: { id: 'asc' }
    });
  }

  // Retourne tous les mots d'une catégorie (ou tous les mots si categoryId = '0')
  async getWordsByCategory(categoryId: string): Promise<Word[]> {
    // Gestion d'erreur si l'ID est vide
    if (!categoryId || categoryId.trim() === '') {
      throw new BadRequestException('Category ID is required');
    }

    if (categoryId == '0') {
      return this.prisma.word.findMany({
        orderBy: { id: 'asc' }
      });
    }

    // Gestion d'erreur si la catégorie n'existe pas
    const categoryExists = await this.prisma.category.findUnique({
      where: { id: categoryId }
    });
    if (!categoryExists) {
      throw new NotFoundException(`Category with ID ${categoryId} not found`);
    }

    return this.prisma.word.findMany({
      where: { categoryId },
      orderBy: { id: 'asc' }
    });
  }

  // Retourne le détail d'un mot spécifique par son ID
  async getWordDetail(wordId: string): Promise<WordDetail> {
    // Gestion d'erreur si l'id est vide
    if (!wordId || wordId.trim() === '') {
      throw new BadRequestException('Word ID is required');
    }

    const detail = await this.prisma.wordDetail.findUnique({
      where: { wordId }
    });

    // Gestion d'erreur si le mot n'existe pas
    if (!detail) {
      throw new NotFoundException(`Word with ID ${wordId} not found`);
    }

    return detail;
  }
}