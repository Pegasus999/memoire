-- DropForeignKey
ALTER TABLE "Attendence" DROP CONSTRAINT "Attendence_kidId_fkey";

-- AlterTable
ALTER TABLE "Kid" ADD COLUMN     "attendenceId" TEXT;

-- AddForeignKey
ALTER TABLE "Kid" ADD CONSTRAINT "Kid_attendenceId_fkey" FOREIGN KEY ("attendenceId") REFERENCES "Attendence"("id") ON DELETE SET NULL ON UPDATE CASCADE;
