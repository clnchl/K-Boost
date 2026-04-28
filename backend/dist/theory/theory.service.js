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
const node_fs_1 = require("node:fs");
const node_path_1 = require("node:path");
let TheoryService = class TheoryService {
    categories;
    words;
    wordDetails;
    constructor() {
        const dataDir = (0, node_path_1.join)(process.cwd(), 'src', 'theory', 'data');
        this.categories = JSON.parse((0, node_fs_1.readFileSync)((0, node_path_1.join)(dataDir, 'categories.json'), 'utf-8'));
        this.words = JSON.parse((0, node_fs_1.readFileSync)((0, node_path_1.join)(dataDir, 'words.json'), 'utf-8'));
        this.wordDetails = JSON.parse((0, node_fs_1.readFileSync)((0, node_path_1.join)(dataDir, 'word_details.json'), 'utf-8'));
    }
    getCategories() {
        return this.categories;
    }
    getWordsByCategory(categoryId) {
        return this.words.filter((word) => word.categoryId === categoryId);
    }
    getWordDetail(wordId) {
        return this.wordDetails.find((detail) => detail.id === wordId);
    }
};
exports.TheoryService = TheoryService;
exports.TheoryService = TheoryService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [])
], TheoryService);
//# sourceMappingURL=theory.service.js.map