# Stage 1: Build the Angular application
FROM node:22.12.0 AS build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build --prod

# Stage 2: Serve the Angular application with Nginx
FROM nginx:alpine

COPY --from=build /app/dist/my-home-app/usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]  