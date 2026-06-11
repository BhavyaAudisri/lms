FROM node:16

WORKDIR /home/ec2-user/lms

COPY lms-nodejs/ /home/ec2-user/lms/

RUN npm install

RUN npm uninstall prisma @prisma/client
RUN npm install prisma@5 @prisma/client@5

RUN npx prisma generate

RUN npm run build

EXPOSE 8080

CMD ["node", "build/index.js"]