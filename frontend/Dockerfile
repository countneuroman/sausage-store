FROM node:16.20.0-alpine3.18 AS builder
WORKDIR /usr/src/app
COPY . .
RUN npm isntall && npm run build


FROM nginxproxy/nginx-proxy:1.4-alpine AS run
COPY --from=builder /usr/src/app/dist/frontend /usr/share/nginx/html/
COPY --from=builder /usr/src/app/nginx.tmpl /app/
