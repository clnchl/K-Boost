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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.TheoryController = void 0;
const common_1 = require("@nestjs/common");
const id_param_dto_1 = require("../common/dto/id-param.dto");
const theory_service_1 = require("./theory.service");
let TheoryController = class TheoryController {
    theoryService;
    constructor(theoryService) {
        this.theoryService = theoryService;
    }
    async getCategories() {
        return this.theoryService.getCategories();
    }
    async getWordsByCategory(params) {
        return this.theoryService.getWordsByCategory(params.id);
    }
    async getWordDetail(params) {
        return this.theoryService.getWordDetail(params.id);
    }
};
exports.TheoryController = TheoryController;
__decorate([
    (0, common_1.Get)('categories'),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], TheoryController.prototype, "getCategories", null);
__decorate([
    (0, common_1.Get)('categories/:id/words'),
    __param(0, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [id_param_dto_1.IdParamDto]),
    __metadata("design:returntype", Promise)
], TheoryController.prototype, "getWordsByCategory", null);
__decorate([
    (0, common_1.Get)('words/:id'),
    __param(0, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [id_param_dto_1.IdParamDto]),
    __metadata("design:returntype", Promise)
], TheoryController.prototype, "getWordDetail", null);
exports.TheoryController = TheoryController = __decorate([
    (0, common_1.Controller)('theory'),
    __metadata("design:paramtypes", [theory_service_1.TheoryService])
], TheoryController);
//# sourceMappingURL=theory.controller.js.map