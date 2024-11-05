# Usa una imagen base de Nginx
FROM nginx:alpine

# Copia la configuración de Nginx
COPY .docker/nginx/default.conf /etc/nginx/conf.d/default.conf

# Expone el puerto
EXPOSE 80