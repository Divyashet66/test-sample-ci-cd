# Base image
FROM node:14

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json /app/

# Install dependencies (including dev dependencies)
RUN npm install

# Copy the application code to the container
COPY . /app/

# Expose a port
EXPOSE 3000

# Set the command to run when the container starts
CMD ["node", "app.js"]

