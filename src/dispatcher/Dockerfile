FROM node:latest
ARG version
ARG component

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY $component/$version /usr/src/app

EXPOSE 8080
RUN npm install
CMD ["npm", "start"]
