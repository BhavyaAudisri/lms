FROM node:22-slim
RUN useradd -m appuser
RUN apt-get update && \
    apt-get install -y openssl && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY api/package*.json ./
RUN npm install
COPY api/ .
RUN npm uninstall prisma @prisma/client
RUN npm install prisma@5 @prisma/client@5 
RUN npx prisma generate

RUN npm run build
RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 8080
CMD ["sh", "-c", "npx prisma migrate deploy && node build/index.js"]