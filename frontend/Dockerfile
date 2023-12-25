FROM node:16.13.2
WORKDIR /app
COPY frontend/ .

RUN npm install
RUN npm run build
RUN npm install -g http-server

EXPOSE 8080
EXPOSE 443

ENTRYPOINT ["http-server ./dist/frontend/ -p 80 --proxy http://sausageapplication:80"]