import { TheoryController } from '../src/theory/theory.controller';

describe('TheoryController.getCategories (unit)', () => {
  it('renvoie les catégories fournies par le service', async () => {
    const fakeCats = [{ id: '0', name: 'Tous' }];
    const mockService = {
      getCategories: jest.fn().mockResolvedValue(fakeCats),
    };

    const controller = new TheoryController(mockService as never);
    const result = await controller.getCategories();

    expect(mockService.getCategories).toHaveBeenCalled();
    expect(result).toEqual(fakeCats);
    expect(result[0]).toHaveProperty('id', '0');
  });
});
