# Build stage
FROM node:20-alpine as build

WORKDIR /app/frontend
COPY package*.json ./
RUN yarn install
COPY . .
RUN yarn run build

EXPOSE 3001

CMD ["yarn", "start"]

# Serve with nginx
# FROM nginx:alpine

# WORKDIR /usr/share/nginx/html

# COPY --from=build /app/frontend/build /usr/share/nginx/html
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# EXPOSE 80

# CMD ["nginx", "-g", "daemon off;"]

# FROM nginx:alpine
# COPY --from=build /app/frontend/build /usr/share/nginx/html

# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]