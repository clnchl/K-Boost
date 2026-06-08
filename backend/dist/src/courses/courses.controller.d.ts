import { HangulExercise } from '@prisma/client';
import { CoursesService } from './courses.service';
import { HangulSessionQueryDto } from './dto/hangul-session-query.dto';
export declare class CoursesController {
    private readonly coursesService;
    constructor(coursesService: CoursesService);
    getHangulExercises(): Promise<HangulExercise[]>;
    getHangulQuizSession(query: HangulSessionQueryDto): Promise<HangulExercise[]>;
}
