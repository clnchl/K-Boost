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
export declare class TheoryService {
    private readonly categories;
    private readonly words;
    private readonly wordDetails;
    constructor();
    getCategories(): Category[];
    getWordsByCategory(categoryId: string): Word[];
    getWordDetail(wordId: string): WordDetail | undefined;
}
