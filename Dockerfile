# Stage 1: Build React
FROM node:16-alpine as build
WORKDIR /app

# Copy package files and install dependencies first for layer caching
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy source code and build the production assets
COPY . .
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:stable-alpine

# Set permissions for Nginx to run as non-root (Security Best Practice)
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid /usr/share/nginx/html /var/cache/nginx /var/log/nginx /etc/nginx/conf.d

# Copy the built files from Stage 1
COPY --from=build /app/build /usr/share/nginx/html
# Ensure custom styles are included
COPY --from=build /app/public/main.css /usr/share/nginx/html/main.css
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Switch to the non-root user
USER nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
