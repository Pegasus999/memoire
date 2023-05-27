/*
  Warnings:

  - A unique constraint covering the columns `[kidId]` on the table `Attendence` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Attendence_kidId_key" ON "Attendence"("kidId");
