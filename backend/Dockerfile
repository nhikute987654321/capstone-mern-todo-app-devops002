
FROM node:20

WORKDIR /app/backend

COPY package*.json ./

RUN yarn config set network-timeout 3000000
RUN yarn install

COPY . .

EXPOSE 8000

ENV NODE_ENV=production
ENV PORT=8000
ENV MONGO_URI=mongodb://mongo:27017/todo
ENV JWT_SECRET=BI_MAT_JWT_SECRET

CMD [ "yarn","start"]
