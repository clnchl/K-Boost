import { HangulExercise } from '@prisma/client';
import { CoursesService } from './courses.service';
export declare class CoursesController {
    private readonly coursesService;
    constructor(coursesService: CoursesService);
    getHangulExercises(): Promise<HangulExercise[]>;
    getHangulQuizSession(count?: string): Promise<HangulExercise[]>;
}
