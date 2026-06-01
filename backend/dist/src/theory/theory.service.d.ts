import { Category, Word, WordDetail } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';
export declare class TheoryService {
    private readonly prisma;
    constructor(prisma: PrismaService);
    getCategories(): Promise<Category[]>;
    getWordsByCategory(categoryId: string): Promise<Word[]>;
    getWordDetail(wordId: string): Promise<WordDetail>;
}
