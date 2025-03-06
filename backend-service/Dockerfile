# get the nodejs base image
FROM node:18-alpine

# set working directory
WORKDIR /app

# get the pacakge.json file contents 
COPY package.json /app/

# run npm install to initialize nodes
RUN npm install

# copy all files in local directory 
COPY . .

# use port 5000
# EXPOSE 5000

CMD [ "npm", "run", "prod"]



