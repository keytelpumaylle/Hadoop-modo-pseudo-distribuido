#!/bin/bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
export HDFS_NAMENODE_USER=root
# Iniciar SSH
service ssh start

# Formatear el NameNode (solo la primera vez)
if [ ! -d "/tmp/hadoop-data/dfs/namenode/current" ]; then
    echo "Formateando NameNode..."
    $HADOOP_HOME/bin/hdfs namenode -format -force
fi

# Iniciar servicios de Hadoop
echo "Iniciando HDFS..."
$HADOOP_HOME/sbin/start-dfs.sh

echo "Iniciando YARN..."
$HADOOP_HOME/sbin/start-yarn.sh

echo "Hadoop iniciado en modo pseudo-distribuido"
echo "NameNode Web UI: http://localhost:9870"
echo "ResourceManager Web UI: http://localhost:8088"

# Mantener el contenedor ejecutándose
tail -f $HADOOP_HOME/logs/*.log
