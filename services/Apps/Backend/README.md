Construcción de Imagen:

```
sudo docker build -t backend .
```

Instanciar contenedor:

```
sudo docker run -p 8000:8000 backend
```

En segundo plano:
```
sudo docker run -d -p 8000:8000 backend
```