# Phase 1 to Prepare for production
FROM node:alpine as builder

WORKDIR /app

COPY package.json .

RUN npm install
RUN npm audit fix --force

COPY . .

RUN npm run build

# Phase 2 to run production
FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html

# The default command for nginx is to start itself