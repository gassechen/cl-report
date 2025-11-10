FROM alpine:latest

# Instalar Roswell y dependencias
RUN apk add --no-cache git make gcc musl-dev sqlite-dev

# Instalar Roswell
RUN git clone https://github.com/roswell/roswell.git \
    && cd roswell \
    && ./bootstrap \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf roswell

# Copiar el código fuente de la aplicación
WORKDIR /app
COPY . .

# Compilar la aplicación con Roswell
RUN ros build myproject.asd

EXPOSE 8000
CMD ["./myproject"]

