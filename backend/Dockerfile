FROM node:22
RUN useradd -m appuser
WORKDIR /app
COPY api/package*.json ./
COPY api/ .
RUN npm run build
RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 8080

CMD ["node", "build/index.js"]