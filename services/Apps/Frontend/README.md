Construcción de Imagen:

```
sudo docker build -t frontend .
```

Instanciar contenedor:

```
sudo docker run -p 3000:3000 frontend
```

En segundo plano:
```
sudo docker run -d -p 3000:3000 frontend
```