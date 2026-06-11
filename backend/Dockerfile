FROM node:16
CMD ["npm", "start"]
WORKDIR /home/ec2-user/
COPY /ms-nodejs /home/ec2-user/lms/
RUN npm install
RUN npm uninstall prisma @prisma/client
RUN npm install prisma@5 @prisma/client@5
RUN npx prisma generate
RUN sudo npx prisma db push
RUN npm run build
RUN node build/index.js
