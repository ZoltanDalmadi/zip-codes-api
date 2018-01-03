FROM node:carbon-alpine
ENV NODE_ENV production
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install --silent
COPY . .
EXPOSE 3000
ENTRYPOINT ["node_modules/.bin/micro"]
