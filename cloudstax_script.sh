#!/bin/bash
echo "Este é o script de instalação e configuração do Cloudfooding"
echo "O script irá fazer diversas modificações na sua máquina"
echo "Tem certeza que deseja continuar? S\n"
read inst
if [ \"$inst\" == \"s\" ]
#Verificando e criando usuário
then echo "Fazendo verificação de usuário"
getent passwd cloudstax
if [ $? -eq 0 ]
then echo \“Este usuário já está cadastrado\”
else echo \"O usuário nao existe, criando usuario\"
sudo adduser cloudstax
sudo usermod -aG sudo cloudstax
su cloudstax
cd
fi

#Atualizando repositórios e pacotes
echo "Atualizando repositórios e pacotes do sistema"
sudo apt-get update && sudo apt-get upgrade -y

#Verificando e instalando o Java
echo "Verificando versão do Java"
java --version
if [ $? -eq 0 ]
then echo \"O Java já está instalado\"
else echo \"O Java está não instalado\"
sudo apt install default-jdk -y
clear
echo \"JAVA instalado na versao 11\"
java --version
sleep 5
fi

echo \"Sera realizado agora, a instalacao cloudfooding, nosso sistema de monitoramento\"
sleep 4
clear

sudo apt update && sudo apt upgrade -y
clear
sudo apt-get install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo docker pull mysql:5.7
sudo docker build -t cloudstax_img:1.0 .
sudo docker run -d -p 3306:3306 --name cloudstax cloudstax_img:1.0
clear

else echo "A instalação foi cancelada"
fi
