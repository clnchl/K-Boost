import { TheoryService, Category, Word, WordDetail } from './theory.service';
export declare class TheoryController {
    private readonly theoryService;
    constructor(theoryService: TheoryService);
    getCategories(): Category[];
    getWordsByCategory(id: string): Word[];
    getWordDetail(id: string): WordDetail | undefined;
}
