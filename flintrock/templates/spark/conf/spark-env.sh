#!/usr/bin/env bash

# Added by me 
wget https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh
mv Anaconda3-2020.07-Linux-x86_64.sh Anaconda3
sh Anaconda3 -y

echo 'export PATH="/home/ec2-user/anaconda3/bin:$PATH"' >> ~/.bashrc
echo 'export SPARK_HOME="/home/ec2-user/spark"' >> ~/.bashrc
echo 'export PATH="$PATH:$SPARK_HOME/bin:$PATH"' >> ~/.bashrc

export SPARK_LOCAL_DIRS="{spark_root_ephemeral_dirs}"

# Standalone cluster options
export SPARK_EXECUTOR_INSTANCES="{spark_executor_instances}"
export SPARK_EXECUTOR_CORES="$(($(nproc) / {spark_executor_instances}))"
export SPARK_WORKER_CORES="$(nproc)"

export SPARK_MASTER_HOST="{master_private_host}"

# TODO: Make this dependent on HDFS install.
export HADOOP_CONF_DIR="$HOME/hadoop/conf"

# TODO: Make this non-EC2-specific.
# Bind Spark's web UIs to this machine's public EC2 hostname
export SPARK_PUBLIC_DNS="$(curl --silent http://169.254.169.254/latest/meta-data/public-hostname)"

# TODO: Set a high ulimit for large shuffles
# Need to find a way to do this, since "sudo ulimit..." doesn't fly.
# Probably need to edit some Linux config file.
# ulimit -n 1000000
