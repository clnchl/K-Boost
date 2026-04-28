export interface Category {
    id: string;
    name: string;
}
export interface Word {
    id: string;
    korean: string;
    translation: string;
    categoryId: string;
}
export interface WordDetail {
    id: string;
    korean: string;
    translation: string;
    definition: string;
    example?: string;
}
export declare class TheoryService {
    private readonly categories;
    private readonly words;
    private readonly wordDetails;
    constructor();
    getCategories(): Category[];
    getWordsByCategory(categoryId: string): Word[];
    getWordDetail(wordId: string): WordDetail | undefined;
}
