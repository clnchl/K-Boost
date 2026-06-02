-- CreateTable
CREATE TABLE "hangul_exercises" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "mode_description" TEXT NOT NULL,
    "prompt" TEXT NOT NULL,
    "correct_choice" TEXT NOT NULL,
    "choices" TEXT[],

    CONSTRAINT "hangul_exercises_pkey" PRIMARY KEY ("id")
);
