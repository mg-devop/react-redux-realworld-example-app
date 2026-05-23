# Stage 1: Build React
FROM node:16-alpine as build
WORKDIR /app
COPY package*.json ./
# Using --legacy-peer-deps handles the dependency conflicts in this older repo
RUN npm install --legacy-peer-deps
COPY . .
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY public/main.css /usr/share/nginx/html/main.css
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
