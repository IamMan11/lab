# Stage 1: Build the Next.js application
FROM node:18-alpine AS builder

WORKDIR /app

# คัดลอก package.json และไฟล์ lock
COPY package.json package-lock.json ./
RUN npm install

# คัดลอกโค้ดทั้งหมด
COPY . .

# Build Next.js
RUN npm run build

# Stage 2: Run the application
FROM node:18-alpine

WORKDIR /app

# คัดลอกไฟล์จาก builder stage
COPY --from=builder /app/package.json /app/package-lock.json ./
COPY --from=builder /app/.next .
