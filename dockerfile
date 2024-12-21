# Stage 1: Build the Angular application
FROM node:22.12.0 AS build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build --prod

# Stage 2: Serve the Angular application with Nginx
FROM nginx:alpine

EXPOSE 8080

copy nginx.conf /etc/nginx/nginx.conf
#COPY --from=build /app/dist/my-home-app/usr/share/nginx/html
COPY --from=build /app/dist/my-home-app/browser /usr/share/nginx/html

