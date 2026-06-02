import { HangulExercise } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';
export declare class CoursesService {
    private readonly prisma;
    constructor(prisma: PrismaService);
    getHangulExercises(): Promise<HangulExercise[]>;
    getHangulQuizSession(count: number): Promise<HangulExercise[]>;
}
