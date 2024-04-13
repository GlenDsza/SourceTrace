FROM node:alpine AS builder

WORKDIR /SourceTrace/

COPY package*.json ./
RUN npm install --legacy-peer-deps

COPY driver/ /SourceTrace/driver
COPY public/ /SourceTrace/public
COPY src/ /SourceTrace/src
COPY . .

RUN npm run build

FROM node:alpine

WORKDIR /SourceTrace
COPY --from=builder /SourceTrace/. .
ENTRYPOINT [ "sh", "-c", "npm run dev & node driver/index.js" ]
EXPOSE 3000 5000