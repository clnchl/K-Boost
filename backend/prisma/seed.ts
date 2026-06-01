import 'dotenv/config';
import { PrismaClient } from '@prisma/client';
import { readFile } from 'node:fs/promises';
import { resolve } from 'node:path';

const prisma = new PrismaClient();

type CategoryJson = {
  id: string;
  name: string;
};

type WordJson = {
  id: string;
  korean: string;
  romanisation: string;
  translation: string;
  categoryId: string;
};

type WordDetailJson = {
  id: string;
  korean: string;
  romanisation: string;
  translation: string;
  grammaticalType: string;
  exampleSentence: string;
};

const baseDir = resolve(__dirname, '..');

async function loadJson<T>(relativePath: string): Promise<T> {
  const absolutePath = resolve(baseDir, relativePath);
  const raw = await readFile(absolutePath, 'utf-8');
  return JSON.parse(raw) as T;
}

async function main() {
  const categories = await loadJson<CategoryJson[]>(
    'src/theory/data/categories.json',
  );
  const words = await loadJson<WordJson[]>('src/theory/data/words.json');
  const wordDetails = await loadJson<WordDetailJson[]>(
    'src/theory/data/word_details.json',
  );

  console.log('Seed cwd:', process.cwd());
  console.log('Seed baseDir:', baseDir);
  console.log('Seed counts:', {
    categories: categories.length,
    words: words.length,
    wordDetails: wordDetails.length,
  });

  if (!categories.length || !words.length || !wordDetails.length) {
    throw new Error('Seed data not found or empty. Check JSON paths.');
  }

  for (const category of categories) {
    await prisma.category.upsert({
      where: { id: category.id },
      update: { name: category.name },
      create: { id: category.id, name: category.name },
    });
  }

  for (const word of words) {
    await prisma.word.upsert({
      where: { id: word.id },
      update: {
        korean: word.korean,
        romanisation: word.romanisation,
        translation: word.translation,
        categoryId: word.categoryId,
      },
      create: {
        id: word.id,
        korean: word.korean,
        romanisation: word.romanisation,
        translation: word.translation,
        categoryId: word.categoryId,
      },
    });
  }

  for (const detail of wordDetails) {
    await prisma.wordDetail.upsert({
      where: { wordId: detail.id },
      update: {
        korean: detail.korean,
        romanisation: detail.romanisation,
        translation: detail.translation,
        grammaticalType: detail.grammaticalType,
        exampleSentence: detail.exampleSentence,
      },
      create: {
        id: detail.id,
        wordId: detail.id,
        korean: detail.korean,
        romanisation: detail.romanisation,
        translation: detail.translation,
        grammaticalType: detail.grammaticalType,
        exampleSentence: detail.exampleSentence,
      },
    });
  }
}

main()
  .catch((error) => {
    console.error('Seed failed:', error);
    process.exitCode = 1;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
