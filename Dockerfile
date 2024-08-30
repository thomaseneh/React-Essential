# build stage
FROM node:20.13.0 AS build
WORKDIR /app
COPY package*.json /app/
RUN npm ci --omit=dev
COPY . .

# final stage
FROM nginx:1.26-alpine-slim
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]