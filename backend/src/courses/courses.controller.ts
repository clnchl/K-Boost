import { Controller, Get, Query } from '@nestjs/common';
import { HangulExercise } from '@prisma/client';
import { CoursesService } from './courses.service';
import { HangulSessionQueryDto } from './dto/hangul-session-query.dto';

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
    @Query() query: HangulSessionQueryDto,
  ): Promise<HangulExercise[]> {
    return this.coursesService.getHangulQuizSession(query.count ?? 10);
  }
}
