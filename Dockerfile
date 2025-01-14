# Stage 1: Build the Vue app
FROM node:18-alpine as build
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci

# Copy source files and build
COPY . .
RUN npm run build

# Stage 2: Serve with Node.js
FROM node:18-alpine
WORKDIR /app

# Copy only necessary files from build stage
COPY --from=build /app/dist ./dist
COPY --from=build /app/package*.json ./
COPY --from=build /app/server.js ./

# Make sure express is listed as a production dependency
RUN npm install express && \
    npm ci --only=production && \
    npm cache clean --force

# Add non-root user for security
USER node

# Enable ES modules
ENV NODE_ENV=production
ENV NODE_OPTIONS=--experimental-modules

EXPOSE 3000
CMD ["node", "server.js"]