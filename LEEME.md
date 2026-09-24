# Valknut Gestión (web + teléfono)

La app vive en GitHub Pages y los datos en Supabase. Solo se puede entrar con tu email y contraseña;
sin eso, la página muestra únicamente la pantalla de acceso y no hay forma de leer tus datos ni tus archivos.

## 1. Supabase (una sola vez)
1. Entrá a https://supabase.com, creá una cuenta y un proyecto nuevo (región: São Paulo, la más cercana).
2. **SQL Editor → New query**: pegá todo el contenido de `supabase.sql` y tocá **Run**.
3. **Authentication → Users → Add user → Create new user**: tu email y una contraseña fuerte. Marcá "Auto Confirm User".
4. **Authentication → Sign In / Providers**: desactivá **"Allow new users to sign up"**. Así nadie más puede crearse una cuenta.
5. **Project Settings → API (o API Keys)**: copiá la **Project URL** y la clave **publishable** (o *anon public*).
   Nunca uses la clave *secret* / *service_role* en la app.

## 2. GitHub Pages
1. Creá un repositorio nuevo (por ejemplo `valknut-gestion`) y subí todos estos archivos, incluida la carpeta `icons`
   y el archivo `.nojekyll`.
2. Editá `config.js` y pegá la URL y la clave del paso 1.5.
3. Copiá las fuentes Roadgeek a `fonts/` (ver `fonts/LEEME.txt`).
4. **Settings → Pages**: Source "Deploy from a branch", rama `main`, carpeta `/ (root)`. En un minuto queda en
   `https://TU-USUARIO.github.io/valknut-gestion/`.

## 3. Instalar
- **Teléfono (Android/Chrome):** abrí el link → menú ⋮ → "Agregar a pantalla de inicio" / "Instalar app".
- **iPhone (Safari):** abrí el link → botón Compartir → "Agregar a pantalla de inicio".
- **PC (Chrome o Edge):** abrí el link → ícono de instalar en la barra de direcciones.

## Pasar los datos del programa de PC
En el programa de PC: Ajustes → Exportar respaldo. En la app web: Ajustes → Importar respaldo.
Los archivos adjuntos del programa de PC no se pasan solos; hay que volver a subirlos.

## Bueno saber
- El plan gratis de Supabase pausa el proyecto si pasa 7 días sin uso. No se pierde nada: se reactiva
  desde el panel de Supabase con un clic.
- Las fotos grandes se achican automáticamente al subirlas para cuidar el espacio (1 GB gratis).
- Los PDF se generan con la ventana de impresión: elegí "Guardar como PDF".
- Cuando cambies algo en GitHub, la app se actualiza sola la próxima vez que la abras con conexión.
