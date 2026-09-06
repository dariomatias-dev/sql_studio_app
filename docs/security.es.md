# Política de Seguridad

<p align="center">
<a href="security.md">English</a> · <strong>Español</strong> · <a href="security.pt-BR.md">Português (BR)</a>
</p>

## Versiones Soportadas

**SQL Studio** se mantiene como código fuente. La única versión soportada es la rama `main` actual: las correcciones de seguridad se aplican ahí y no se retroportan a commits anteriores.

## Reportar una Vulnerabilidad

Por favor, **no** abras un issue público de GitHub para reportar una vulnerabilidad de seguridad.

En su lugar, envía un correo a [dariomatias.dev@gmail.com](mailto:dariomatias.dev@gmail.com) que contenga:

- Una descripción de la vulnerabilidad y su impacto potencial.
- Pasos para reproducirla (un ejemplo mínimo es especialmente útil).
- El commit desde el que compilaste y la versión de Android en la que probaste.

Este es un proyecto de código abierto mantenido en solitario, a escala de hobby: no hay un equipo de seguridad dedicado ni un SLA formal, pero cada reporte se toma en serio y se confirma la recepción lo antes posible. Una vez publicada la corrección, se acreditará a quien reportó, salvo que prefiera permanecer anónimo.

## Alcance

La app funciona completamente sin conexión: mantiene un conjunto fijo de bases de datos de ejemplo incluidas y las que el usuario cree, guarda todo localmente (SQLite vía `sqflite`, `shared_preferences`), y no hace peticiones de red. El tipo de problema más relevante es, por lo tanto, local: el SQL que la propia app ejecuta (tanto los assets de esquema/semilla incluidos como el divisor de sentencias de la consola, que debe manejar un punto y coma o una palabra clave dentro de un literal de texto o comentario sin interpretar mal la sentencia) y cómo la app almacena datos en el dispositivo. Los problemas relacionados con servidor o cuenta no aplican, ya que no hay ni servidor ni cuenta.
