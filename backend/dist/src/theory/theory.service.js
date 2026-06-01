"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.TheoryService = void 0;
const common_1 = require("@nestjs/common");
const common_2 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let TheoryService = class TheoryService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async getCategories() {
        return this.prisma.category.findMany({
            orderBy: { id: 'asc' }
        });
    }
    async getWordsByCategory(categoryId) {
        if (!categoryId || categoryId.trim() === '') {
            throw new common_2.BadRequestException('Category ID is required');
        }
        if (categoryId == '0') {
            return this.prisma.word.findMany({
                orderBy: { id: 'asc' }
            });
        }
        const categoryExists = await this.prisma.category.findUnique({
            where: { id: categoryId }
        });
        if (!categoryExists) {
            throw new common_2.NotFoundException(`Category with ID ${categoryId} not found`);
        }
        return this.prisma.word.findMany({
            where: { categoryId },
            orderBy: { id: 'asc' }
        });
    }
    async getWordDetail(wordId) {
        if (!wordId || wordId.trim() === '') {
            throw new common_2.BadRequestException('Word ID is required');
        }
        const detail = await this.prisma.wordDetail.findUnique({
            where: { wordId }
        });
        if (!detail) {
            throw new common_2.NotFoundException(`Word with ID ${wordId} not found`);
        }
        return detail;
    }
};
exports.TheoryService = TheoryService;
exports.TheoryService = TheoryService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], TheoryService);
//# sourceMappingURL=theory.service.js.map