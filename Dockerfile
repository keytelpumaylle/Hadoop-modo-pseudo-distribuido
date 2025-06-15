FROM openjdk:8-jdk-slim

# Variables de entorno
ENV HADOOP_VERSION=3.3.6
ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV JAVA_HOME=/usr/local/openjdk-8

ENV HDFS_NAMENODE_USER=root
ENV HDFS_DATANODE_USER=root
ENV HDFS_SECONDARYNAMENODE_USER=root
ENV YARN_RESOURCEMANAGER_USER=root
ENV YARN_NODEMANAGER_USER=root

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    ssh \
    rsync \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Descargar e instalar Hadoop
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz \
    && tar -xzf hadoop-$HADOOP_VERSION.tar.gz \
    && mv hadoop-$HADOOP_VERSION $HADOOP_HOME \
    && rm hadoop-$HADOOP_VERSION.tar.gz

# Configurar SSH sin contraseña
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
    && chmod 0600 ~/.ssh/authorized_keys

# Crear directorios necesarios
RUN mkdir -p /opt/hadoop/logs \
    && mkdir -p /tmp/hadoop-data/dfs/namenode \
    && mkdir -p /tmp/hadoop-data/dfs/datanode

# Copiar archivos de configuración
COPY config/ $HADOOP_CONF_DIR/

WORKDIR $HADOOP_HOME

# Exponer puertos
EXPOSE 9870 9000 8088 19888 8042 8888

# Script de inicio
COPY start-hadoop.sh /start-hadoop.sh
RUN chmod +x /start-hadoop.sh

CMD ["/start-hadoop.sh"]
