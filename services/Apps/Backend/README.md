Construcción de Imagen:

```
sudo docker build -t backend .
```

Instanciar contenedor:

```
sudo docker run -p 80:80 backend
```

En segundo plano:
```
sudo docker run -d -p 80:80 backend
```