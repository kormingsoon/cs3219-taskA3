FROM nginx:alpine
COPY ./nginx-html/default.conf etc/nginx/default.conf 
COPY ./nginx-html/index.html /usr/share/nginx/html/index.html
