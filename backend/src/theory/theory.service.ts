import { Injectable } from '@nestjs/common';
import { readFileSync } from 'node:fs';
import { join } from 'node:path';

export interface Category {
  id: string;
  name: string;
}

export interface Word {
  id: string;
  korean: string;
  romanisation: string;
  translation: string;
  categoryId: string;
}

export interface WordDetail {
  id: string;
  korean: string;
  romanisation: string;
  translation: string;
  grammaticalType: string;
  exampleSentence: string;
}

// Ce service gère toute la logique métier pour récupérer les données de la théorie
@Injectable()
export class TheoryService {
  // Les données sont stockées dans des variables privées
  private readonly categories: Category[];
  private readonly words: Word[];
  private readonly wordDetails: WordDetail[];

  // Au démarrage, le service lit les fichiers JSON 
  constructor() {
    const dataDir = join(process.cwd(), 'src', 'theory', 'data');

    // Lit et parse categories.json
    this.categories = JSON.parse(
      readFileSync(join(dataDir, 'categories.json'), 'utf-8')
    ) as Category[];

    // Lit et parse words.json
    this.words = JSON.parse(
      readFileSync(join(dataDir, 'words.json'), 'utf-8')
    ) as Word[];

    // Lit et parse word_details.json
    this.wordDetails = JSON.parse(
      readFileSync(join(dataDir, 'word_details.json'), 'utf-8')
    ) as WordDetail[];
  }

  // Retourne toutes les catégories
  getCategories(): Category[] {
    return this.categories;
  }

  // Retourne tous les mots d'une catégorie (ou tous les mots si categoryId = '0')
  getWordsByCategory(categoryId: string): Word[] {
    if (categoryId == '0') {
      return this.words;
    }
    return this.words.filter((word) => word.categoryId === categoryId);
  }

  // Retourne le détail d'un mot spécifique par son ID
  getWordDetail(wordId: string): WordDetail | undefined {
    return this.wordDetails.find((detail) => detail.id === wordId);
  }
}