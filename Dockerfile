# Use an official Node.js runtime as a parent image
FROM node:22-alpine as builder

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Vite project
RUN npm run build

# Expose the port the app runs on
EXPOSE 4173

# Command to run the app
CMD ["npm", "run", "preview"]