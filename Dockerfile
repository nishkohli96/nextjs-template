FROM node:23-alpine3.20 AS builder

# Set working directory in the container
WORKDIR /app

COPY --chown=node:node package.json tsconfig.json pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install --frozen-lockfile --non-interactive

# Copy the rest of the application code to the container
COPY --chown=node:node . .

# Build the Next.js app
RUN pnpm build

# Production image
FROM node:23-alpine3.20 AS runner

# Set working directory in the container
WORKDIR /app

# Copy only the necessary build files from the builder stage
COPY --from=builder /app/package.json /app/pnpm-lock.yaml ./
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules

# Next.js collects completely anonymous telemetry data about general usage.
# Learn more here: https://nextjs.org/telemetry
# Optional: Disable telemetry
ENV NEXT_TELEMETRY_DISABLED 1

# Set environment to production
ENV NODE_ENV production

# Expose the port the Next.js app runs on (default: 3000)
EXPOSE 3000

# Start the application
CMD ["pnpm", "start"]

