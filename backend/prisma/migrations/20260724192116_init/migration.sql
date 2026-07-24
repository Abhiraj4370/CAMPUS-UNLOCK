-- CreateEnum
CREATE TYPE "Role" AS ENUM ('STUDENT', 'ADMIN');

-- CreateEnum
CREATE TYPE "UniversityType" AS ENUM ('GOVERNMENT', 'PRIVATE', 'DEEMED');

-- CreateEnum
CREATE TYPE "LeadPurpose" AS ENUM ('ADMISSION', 'COUNSELLING', 'CONTACT', 'SCHOLARSHIP');

-- CreateEnum
CREATE TYPE "LeadStatus" AS ENUM ('NEW', 'IN_PROGRESS', 'RESOLVED');

-- CreateEnum
CREATE TYPE "ApplicationStatus" AS ENUM ('SUBMITTED', 'UNDER_REVIEW', 'ADMITTED', 'REJECTED');

-- CreateEnum
CREATE TYPE "WidgetType" AS ENUM ('FEATURE', 'TRUST_BADGE', 'STAT');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone" TEXT,
    "role" "Role" NOT NULL DEFAULT 'STUDENT',
    "interestArea" TEXT,
    "city" TEXT,
    "bio" TEXT,
    "avatar" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "University" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "type" "UniversityType" NOT NULL DEFAULT 'PRIVATE',
    "location" TEXT NOT NULL,
    "establishedYear" INTEGER NOT NULL,
    "logo" TEXT,
    "banner" TEXT,
    "about" TEXT NOT NULL,
    "rating" DOUBLE PRECISION NOT NULL DEFAULT 4.5,
    "totalReviews" INTEGER NOT NULL DEFAULT 0,
    "totalCourses" INTEGER NOT NULL DEFAULT 0,
    "totalStudents" INTEGER NOT NULL DEFAULT 0,
    "totalFaculty" INTEGER NOT NULL DEFAULT 0,
    "placementRate" TEXT NOT NULL DEFAULT '90%',
    "avgFees" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "accreditation" TEXT NOT NULL DEFAULT 'A+',
    "naacGrade" TEXT NOT NULL DEFAULT 'A+',
    "ugcEntitled" BOOLEAN NOT NULL DEFAULT true,
    "aicteApproved" BOOLEAN NOT NULL DEFAULT true,
    "brochureUrl" TEXT,
    "isFeatured" BOOLEAN NOT NULL DEFAULT false,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "categoryId" TEXT,

    CONSTRAINT "University_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "icon" TEXT NOT NULL DEFAULT '📚',
    "courseCountLabel" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Course" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "duration" TEXT NOT NULL,
    "fee" DOUBLE PRECISION NOT NULL,
    "rating" DOUBLE PRECISION NOT NULL DEFAULT 4.5,
    "totalReviews" INTEGER NOT NULL DEFAULT 0,
    "tag" TEXT,
    "level" TEXT NOT NULL DEFAULT 'Postgraduate',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "universityId" TEXT NOT NULL,

    CONSTRAINT "Course_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Scholarship" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "amountText" TEXT NOT NULL,
    "deadline" TIMESTAMP(3) NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "universityId" TEXT,

    CONSTRAINT "Scholarship_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Review" (
    "id" TEXT NOT NULL,
    "rating" INTEGER NOT NULL DEFAULT 5,
    "courseName" TEXT,
    "comment" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT NOT NULL,
    "universityId" TEXT NOT NULL,

    CONSTRAINT "Review_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Mentor" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "designation" TEXT NOT NULL,
    "specialty" TEXT,
    "bio" TEXT,
    "photo" TEXT,
    "experienceYears" INTEGER NOT NULL DEFAULT 3,
    "studentsHelped" INTEGER NOT NULL DEFAULT 500,
    "isActive" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Mentor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Lead" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT,
    "purpose" "LeadPurpose" NOT NULL DEFAULT 'ADMISSION',
    "message" TEXT,
    "status" "LeadStatus" NOT NULL DEFAULT 'NEW',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "universityId" TEXT,

    CONSTRAINT "Lead_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Blog" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "category" TEXT NOT NULL DEFAULT 'Guides',
    "excerpt" TEXT NOT NULL,
    "body" TEXT NOT NULL,
    "cover" TEXT,
    "isPublished" BOOLEAN NOT NULL DEFAULT true,
    "publishedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "authorId" TEXT,

    CONSTRAINT "Blog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Shortlist" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT NOT NULL,
    "universityId" TEXT NOT NULL,

    CONSTRAINT "Shortlist_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Application" (
    "id" TEXT NOT NULL,
    "status" "ApplicationStatus" NOT NULL DEFAULT 'SUBMITTED',
    "appliedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT NOT NULL,
    "universityId" TEXT NOT NULL,
    "courseId" TEXT,

    CONSTRAINT "Application_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SavedSearch" (
    "id" TEXT NOT NULL,
    "query" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT NOT NULL,

    CONSTRAINT "SavedSearch_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Setting" (
    "id" INTEGER NOT NULL DEFAULT 1,
    "siteName" TEXT NOT NULL DEFAULT 'Campus Unlock',
    "supportEmail" TEXT NOT NULL DEFAULT 'support@campusunlock.com',
    "supportPhone" TEXT NOT NULL DEFAULT '1800-123-4567',
    "address" TEXT NOT NULL DEFAULT 'Noida, Uttar Pradesh, India',

    CONSTRAINT "Setting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Widget" (
    "id" TEXT NOT NULL,
    "widgetType" "WidgetType" NOT NULL DEFAULT 'FEATURE',
    "icon" TEXT NOT NULL DEFAULT '⭐',
    "title" TEXT NOT NULL,
    "description" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "position" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "Widget_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "University_slug_key" ON "University"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Category_name_key" ON "Category"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Category_slug_key" ON "Category"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Course_slug_key" ON "Course"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Blog_slug_key" ON "Blog"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Shortlist_userId_universityId_key" ON "Shortlist"("userId", "universityId");

-- AddForeignKey
ALTER TABLE "University" ADD CONSTRAINT "University_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Course" ADD CONSTRAINT "Course_universityId_fkey" FOREIGN KEY ("universityId") REFERENCES "University"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Scholarship" ADD CONSTRAINT "Scholarship_universityId_fkey" FOREIGN KEY ("universityId") REFERENCES "University"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_universityId_fkey" FOREIGN KEY ("universityId") REFERENCES "University"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Lead" ADD CONSTRAINT "Lead_universityId_fkey" FOREIGN KEY ("universityId") REFERENCES "University"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Blog" ADD CONSTRAINT "Blog_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Shortlist" ADD CONSTRAINT "Shortlist_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Shortlist" ADD CONSTRAINT "Shortlist_universityId_fkey" FOREIGN KEY ("universityId") REFERENCES "University"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_universityId_fkey" FOREIGN KEY ("universityId") REFERENCES "University"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Course"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SavedSearch" ADD CONSTRAINT "SavedSearch_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
