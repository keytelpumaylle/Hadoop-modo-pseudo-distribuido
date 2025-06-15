# 🐘 Hadoop Pseudo-Distribuido con Docker

Configuración de un clúster Hadoop de un solo nodo en modo pseudo-distribuido usando Docker.

![Hadoop Ecosystem](https://img.shields.io/badge/Hadoop-3.3.6-yellowgreen)
![Docker Ready](https://img.shields.io/badge/Docker-Containers-blue)

## 🚀 Características Principales

- ✅ Instalación automática de Hadoop 3.3.6
- 🔄 Script de inicio auto-configurable
- 🌐 Servicios web integrados (HDFS/YARN)
- 🐳 Configuración optimizada para contenedores

## 📂 Estructura de Archivos
```bash
├── config
│   ├── core-site.xml
│   ├── hadoop-env.sh
│   ├── hdfs-site.xml
│   ├── mapred-site.xml
│   └── yarn-site.xml
├── Dockerfile
└── start-hadoop.sh
```

## 🛠 Uso Rápido

### 1. Clonar repositorio
```bash
git clone https://github.com/keytelpumaylle/Hadoop-modo-pseudo-distribuido.git

cd Hadoop-modo-pseudo-distribuido
```
### 2. Construir imagen Docker
```bash
docker build -t hadoop-pseudo-distributed .
```

### 3. Ejecutar contenedor
```bash
docker run -it \
  --name hadoop-cluster \
  --hostname hadoop-node \
  -p 9870:9870 \
  -p 8088:8088 \
  -p 9000:9000 \
  -p 8042:8042 \
  -p 19888:19888 \
  hadoop-pseudo-distributed
```
### 4.  🌐 Interfaz Web
- **NameNode UI:** [http://localhost:9870](http://localhost:9870)
- **ResourceManager UI:** [http://localhost:8088](http://localhost:8088)
  
