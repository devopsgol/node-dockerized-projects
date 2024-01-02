FROM node:latest
WORKDIR /apps
ADD . .
RUN npm install
EXPOSE 3000
CMD ["node", "index.js"]
