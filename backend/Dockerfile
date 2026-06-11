FROM node:22-slim
WORKDIR /app
COPY . .

RUN npm install

RUN npm uninstall prisma @prisma/client
RUN npm install prisma@5 @prisma/client@5

RUN npx prisma generate

RUN npm run build

EXPOSE 8080

CMD ["node", "build/index.js"]