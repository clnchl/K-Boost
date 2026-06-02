import { Controller, Get, Query } from '@nestjs/common';
import { HangulExercise } from '@prisma/client';
import { CoursesService } from './courses.service';

// API REST du module Cours (préfixe /courses).
// Quiz Hangul : préférer /hangul/exercises/session pour une partie (10 questions aléatoires).
@Controller('courses')
export class CoursesController {
  constructor(private readonly coursesService: CoursesService) {}

  @Get('hangul/exercises')
  async getHangulExercises(): Promise<HangulExercise[]> {
    return this.coursesService.getHangulExercises();
  }

  @Get('hangul/exercises/session')
  async getHangulQuizSession(
    @Query('count') count?: string,
  ): Promise<HangulExercise[]> {
    const parsed = Number.parseInt(count ?? '10', 10);
    return this.coursesService.getHangulQuizSession(
      Number.isNaN(parsed) ? 10 : parsed,
    );
  }
}
