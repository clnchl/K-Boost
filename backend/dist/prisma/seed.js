"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv/config");
const client_1 = require("@prisma/client");
const promises_1 = require("node:fs/promises");
const node_path_1 = require("node:path");
const prisma = new client_1.PrismaClient();
const baseDir = (0, node_path_1.resolve)(__dirname, "..");
async function loadJson(relativePath) {
    const absolutePath = (0, node_path_1.resolve)(baseDir, relativePath);
    const raw = await (0, promises_1.readFile)(absolutePath, "utf-8");
    return JSON.parse(raw);
}
async function main() {
    const categories = await loadJson("src/theory/data/categories.json");
    const words = await loadJson("src/theory/data/words.json");
    const wordDetails = await loadJson("src/theory/data/word_details.json");
    console.log("Seed cwd:", process.cwd());
    console.log("Seed baseDir:", baseDir);
    console.log("Seed counts:", {
        categories: categories.length,
        words: words.length,
        wordDetails: wordDetails.length,
    });
    if (!categories.length || !words.length || !wordDetails.length) {
        throw new Error("Seed data not found or empty. Check JSON paths.");
    }
    for (const category of categories) {
        await prisma.category.upsert({
            where: { id: category.id },
            update: { name: category.name },
            create: { id: category.id, name: category.name },
        });
    }
    for (const word of words) {
        await prisma.word.upsert({
            where: { id: word.id },
            update: {
                korean: word.korean,
                romanisation: word.romanisation,
                translation: word.translation,
                categoryId: word.categoryId,
            },
            create: {
                id: word.id,
                korean: word.korean,
                romanisation: word.romanisation,
                translation: word.translation,
                categoryId: word.categoryId,
            },
        });
    }
    for (const detail of wordDetails) {
        await prisma.wordDetail.upsert({
            where: { wordId: detail.id },
            update: {
                korean: detail.korean,
                romanisation: detail.romanisation,
                translation: detail.translation,
                grammaticalType: detail.grammaticalType,
                exampleSentence: detail.exampleSentence,
            },
            create: {
                id: detail.id,
                wordId: detail.id,
                korean: detail.korean,
                romanisation: detail.romanisation,
                translation: detail.translation,
                grammaticalType: detail.grammaticalType,
                exampleSentence: detail.exampleSentence,
            },
        });
    }
}
main()
    .catch((error) => {
    console.error("Seed failed:", error);
    process.exitCode = 1;
})
    .finally(async () => {
    await prisma.$disconnect();
});
//# sourceMappingURL=seed.js.map