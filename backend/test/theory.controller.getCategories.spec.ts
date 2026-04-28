import { TheoryController } from '../src/theory/theory.controller';

// Ce test vérifie que le controller transmet bien les données du service vers le front
describe('TheoryController.getCategories (unit)', () => {
  it('le controller renvoie bien les catégories que le service lui donne', () => {
    // On crée un faux service
    const fakeCats = [{ id: '0', name: 'Tous' }];
    const mockService: any = { getCategories: () => fakeCats };

    // On crée le controller avec ce faux service
    const controller = new TheoryController(mockService);
    const result = controller.getCategories();

    // On vérifie que le controller renvoie ce qu'on a mis dans le faux service
    expect(result).toBe(fakeCats);
    expect(Array.isArray(result)).toBe(true);
    expect(result[0]).toHaveProperty('id', '0');
  });
});
