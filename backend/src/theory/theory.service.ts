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

@Injectable()
export class TheoryService {
  private readonly categories: Category[];
  private readonly words: Word[];
  private readonly wordDetails: WordDetail[];

  constructor() {
    const dataDir = join(process.cwd(), 'src', 'theory', 'data');

    this.categories = JSON.parse(
      readFileSync(join(dataDir, 'categories.json'), 'utf-8')
    ) as Category[];

    this.words = JSON.parse(
      readFileSync(join(dataDir, 'words.json'), 'utf-8')
    ) as Word[];

    this.wordDetails = JSON.parse(
      readFileSync(join(dataDir, 'word_details.json'), 'utf-8')
    ) as WordDetail[];
  }

  getCategories(): Category[] {
    return this.categories;
  }

  getWordsByCategory(categoryId: string): Word[] {
    if (categoryId == '0') {
      return this.words;
    }
    return this.words.filter((word) => word.categoryId === categoryId);
  }

  getWordDetail(wordId: string): WordDetail | undefined {
    return this.wordDetails.find((detail) => detail.id === wordId);
  }
}