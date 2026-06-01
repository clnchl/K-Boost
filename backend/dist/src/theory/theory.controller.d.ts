import { Category, Word, WordDetail } from '@prisma/client';
import { TheoryService } from './theory.service';
export declare class TheoryController {
    private readonly theoryService;
    constructor(theoryService: TheoryService);
    getCategories(): Promise<Category[]>;
    getWordsByCategory(id: string): Promise<Word[]>;
    getWordDetail(id: string): Promise<WordDetail>;
}
