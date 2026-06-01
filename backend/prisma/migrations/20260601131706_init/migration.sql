-- CreateTable
CREATE TABLE "categories" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "words" (
    "id" TEXT NOT NULL,
    "korean" TEXT NOT NULL,
    "romanisation" TEXT NOT NULL,
    "translation" TEXT NOT NULL,
    "categoryId" TEXT NOT NULL,

    CONSTRAINT "words_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "word_details" (
    "id" TEXT NOT NULL,
    "wordId" TEXT NOT NULL,
    "korean" TEXT NOT NULL,
    "romanisation" TEXT NOT NULL,
    "translation" TEXT NOT NULL,
    "grammaticalType" TEXT NOT NULL,
    "exampleSentence" TEXT NOT NULL,

    CONSTRAINT "word_details_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "words_categoryId_idx" ON "words"("categoryId");

-- CreateIndex
CREATE UNIQUE INDEX "word_details_wordId_key" ON "word_details"("wordId");

-- AddForeignKey
ALTER TABLE "words" ADD CONSTRAINT "words_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "word_details" ADD CONSTRAINT "word_details_wordId_fkey" FOREIGN KEY ("wordId") REFERENCES "words"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
