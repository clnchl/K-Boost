import { Test, TestingModule } from '@nestjs/testing';
import { TheoryService } from '../src/theory/theory.service';

// Ce test vérifie que le service récupère bien les catégories depuis les fichiers JSON
describe('TheoryService.getCategories (unit)', () => {
  let service: TheoryService;

  beforeAll(async () => {
    // On crée le service au début du test
    const module: TestingModule = await Test.createTestingModule({
      providers: [TheoryService],
    }).compile();
    service = module.get<TheoryService>(TheoryService);
  });

  it('le service renvoie un tableau de catégories avec id et name', () => {
    // On appelle la méthode getCategories()
    const cats = service.getCategories();
    // On vérifie que c'est un tableau
    expect(Array.isArray(cats)).toBe(true);
    // On vérifie qu'il est pas vide
    expect(cats.length).toBeGreaterThan(0);
    // On vérifie que chaque catégorie a les bonnes propriétés
    expect(cats[0]).toHaveProperty('id');
    expect(cats[0]).toHaveProperty('name');
  });
});
