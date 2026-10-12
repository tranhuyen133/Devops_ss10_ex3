# ---- Stage 1: builder ----
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# ---- Stage 2: runtime (nhẹ) ----
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/server.js ./
ENV PORT=3000
EXPOSE 3000
CMD ["node", "server.js"]
