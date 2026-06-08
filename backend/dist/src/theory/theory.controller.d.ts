import { Category, Word, WordDetail } from '@prisma/client';
import { IdParamDto } from '../common/dto/id-param.dto';
import { TheoryService } from './theory.service';
export declare class TheoryController {
    private readonly theoryService;
    constructor(theoryService: TheoryService);
    getCategories(): Promise<Category[]>;
    getWordsByCategory(params: IdParamDto): Promise<Word[]>;
    getWordDetail(params: IdParamDto): Promise<WordDetail>;
}
