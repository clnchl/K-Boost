import { Test, TestingModule } from '@nestjs/testing';
import { TheoryService } from '../src/theory/theory.service';
import { PrismaService } from '../src/prisma/prisma.service';

describe('TheoryService.getCategories (unit)', () => {
  let service: TheoryService;

  const mockCategories = [
    { id: '0', name: 'Tous les mots' },
    { id: '1', name: 'Pronoms' },
  ];

  const prisma = {
    category: {
      findMany: jest.fn().mockResolvedValue(mockCategories),
    },
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        TheoryService,
        { provide: PrismaService, useValue: prisma },
      ],
    }).compile();

    service = module.get<TheoryService>(TheoryService);
    jest.clearAllMocks();
  });

  it('renvoie les catégories depuis la base de données', async () => {
    const cats = await service.getCategories();

    expect(prisma.category.findMany).toHaveBeenCalledWith({
      orderBy: { id: 'asc' },
    });
    expect(cats).toEqual(mockCategories);
    expect(cats[0]).toHaveProperty('id');
    expect(cats[0]).toHaveProperty('name');
  });
});
