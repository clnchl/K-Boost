import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import request from 'supertest';
import { App } from 'supertest/types';
import { AppModule } from '../src/app.module';

describe('TheoryController (e2e)', () => {
  let app: INestApplication<App>;

  beforeEach(async () => {
    // Il démarre le backend en mode test
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();
  });

  it('GET /theory/categories - appelle la route et vérifie que le backend renvoie bien des catégories', () => {
    // Il appelle la route /theory/categories
    return request(app.getHttpServer())
      .get('/theory/categories')
      .expect(200)
      // Il vérifie que le backend renvoie bien des catégories
      .expect((res) => {
        expect(Array.isArray(res.body)).toBe(true);
        expect(res.body.length).toBeGreaterThan(0);
        expect(res.body[0]).toHaveProperty('id');
        expect(res.body[0]).toHaveProperty('name');
      });
  });

  afterEach(async () => {
    await app.close();
  });
});
