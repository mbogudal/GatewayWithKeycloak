# ======================
# 1. Build stage
# ======================
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# ======================
# 2. Runtime stage
# ======================
FROM node:20-alpine AS runner

WORKDIR /app
ENV NODE_ENV=production

# kopiujemy standalone output
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

EXPOSE 3000

CMD ["node", "server.js"]

#docker build -t login .
#docker run -p 3000:3000 login