FROM node:16.20.0-alpine3.18 AS builder
WORKDIR /usr/src/app
COPY . .
RUN npm isntall && npm run build


FROM nginx:stable-alpine3.17-slim AS run
WORKDIR /var/www/html
COPY --from=builder /usr/src/app/dist/frontend .
COPY default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
