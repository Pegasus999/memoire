/*
  Warnings:

  - You are about to drop the column `attendenceId` on the `Kid` table. All the data in the column will be lost.
  - You are about to drop the column `present` on the `Kid` table. All the data in the column will be lost.
  - You are about to drop the `Attendence` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Kid" DROP CONSTRAINT "Kid_attendenceId_fkey";

-- AlterTable
ALTER TABLE "Kid" DROP COLUMN "attendenceId",
DROP COLUMN "present",
ADD COLUMN     "eveningPresent" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "morningPresent" BOOLEAN NOT NULL DEFAULT false;

-- DropTable
DROP TABLE "Attendence";
