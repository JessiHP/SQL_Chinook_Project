## Proyecto SQL – Lógica y Consultas sobre la base de datos Chinook

Este proyecto forma parte del curso de ThePower y consiste en resolver retos de negocio mediante el uso de **SQL aplicado sobre la base de datos Chinook**, utilizando consultas, subconsultas, joins, vistas y CTEs.

### 📁 Estructura del repositorio 



| Carpeta                     | Descripción                                      |
|----------------------------|--------------------------------------------------|
| 📊 1_BBDD_chinook.sql         | Script SQL para la creación y carga de la base de datos (formato PostgreSQL)         |
| 📊 2_Consultas.sql | Archivo con todas las consultas resueltas                        |
| 📄 3_Planteamiento_consulta.pdf            | Documento con los enunciados de las consultas planteadas|
| 📝 4_README.md            | Este documento                   |
└── Esquema_BBDD.png: Imagen del esquema visual de las tablas y relaciones


![alt text](image.png)

### 🛠️ Pasos seguidos

1. **Importación de la base de datos**  
   Se ejecuta el script `1_BBDD_chinook.sql` en DBeaver para crear todas las tablas necesarias.

2. **Análisis de estructura**  
   Se revisan las relaciones, claves foráneas y dependencias para entender la lógica del modelo de datos.

3. **Resolución de consultas**  
   A partir del archivo `3_Planteamiento_consulta.pdf`, se desarrollan todas las consultas aplicando:
   - Comprensión del enunciado
   - Buenas prácticas SQL (alias claros, formato, comentarios)
   - Optimización y legibilidad del código

### 🧠 Resumen de Insights Analizados

A través de este proyecto se abordan preguntas clave como:

- 💰 ¿Qué clientes gastan más o por encima del promedio?
- 🎵 ¿Qué géneros musicales son los más comprados y por quién?
- 📦 ¿Qué álbumes o canciones son más caros o frecuentes en ventas?
- 📈 ¿Qué artistas tienen más presencia en el catálogo?
- 🧾 ¿Cómo se conectan clientes, facturas, tracks y géneros?



### 📘 Tablas de la base de datos *Chinook*

| Tabla            | Descripción |
|------------------|-------------|
| `Album`          | Álbumes musicales con `AlbumId`, `Title`, y `ArtistId`. |
| `Artist`         | Artistas con `ArtistId` y `Name`. |
| `Customer`       | Clientes con `CustomerId`, datos personales y `SupportRepId`. |
| `Employee`       | Empleados de la tienda con `EmployeeId` y datos. |
| `Genre`          | Géneros musicales con `GenreId` y `Name`. |
| `Invoice`        | Facturas con `InvoiceId`, `CustomerId` y otros datos. |
| `InvoiceLine`    | Detalles de factura: `InvoiceLineId`, `TrackId`, `UnitPrice`, `Quantity`. |
| `MediaType`      | Tipos de archivo (`MediaTypeId`, `Name`). |
| `Playlist`       | Listas de reproducción (`PlaylistId`, `Name`). |
| `PlaylistTrack`  | Asociación entre listas y pistas (`PlaylistId`, `TrackId`). |
| `Track`          | Pistas musicales con `TrackId` y metadatos asociados. |



### 📌 Tecnologías y herramientas usadas

- PostgreSQL
- DBeaver como entorno de consulta
- Markdown para documentación clara y estructurada


### ✍️ ¡Gracias por revisar este proyecto!

Para más información, sugerencias o feedback, no dudes en contactarme o visitar mi perfil:

- [![GitHub](https://img.shields.io/badge/GitHub-%2312100E.svg?style=flat&logo=github&logoColor=white)](https://github.com/JessiHP)
- [![LinkedIn](https://img.shields.io/badge/LinkedIn-%230077B5.svg?style=flat&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/jmhp)

