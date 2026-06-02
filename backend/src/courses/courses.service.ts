import { Injectable } from '@nestjs/common';
import { HangulExercise } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';

/**
 * Logique métier du module Cours (exercices Hangul en base).
 * - getHangulExercises : catalogue complet
 * - getHangulQuizSession : sous-ensemble aléatoire pour une partie (évite les doublons)
 */
@Injectable()
export class CoursesService {
  constructor(private readonly prisma: PrismaService) {}

  async getHangulExercises(): Promise<HangulExercise[]> {
    return this.prisma.hangulExercise.findMany({
      orderBy: { id: 'asc' },
    });
  }

  /**
   * Tire `count` exercices différents pour une partie.
   * Mélange en mémoire (OK pour ~24–1000 lignes ; plus tard : filtre par module + SQL RANDOM()).
   */
  async getHangulQuizSession(count: number): Promise<HangulExercise[]> {
    const safeCount = Math.min(Math.max(count, 1), 50);
    const all = await this.prisma.hangulExercise.findMany();

    for (let i = all.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [all[i], all[j]] = [all[j], all[i]];
    }

    return all.slice(0, Math.min(safeCount, all.length));
  }
}
