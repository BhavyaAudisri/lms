FROM node:22-bookworm AS builder

WORKDIR /app

COPY webapp/package*.json ./
RUN npm install

COPY webapp/ ./
RUN npm run build

FROM nginx:1.28-bookworm
COPY default.conf /etc/nginx/conf.d/default.conf

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/dist/ /usr/share/nginx/html/

RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
