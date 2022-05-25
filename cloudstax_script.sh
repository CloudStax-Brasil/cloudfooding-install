#!/bin/bash

#Verificando e criando usuário
getent passwd cloudstax
if [ $? -eq 0 ]
then echo \“Usuario ja existente\”

else echo \"Usuario nao existe, criando usuario\"
sudo adduser cloudstax
sudo usermod -aG sudo cloudstax
sudo chpasswd cloudstax:urubu100
su cloudstax -p urubu100
fi

#Atualizando repositórios e pacotes
sudo apt-get update && sudo apt-get upgrade -y

#Verificando e instalando o Java
java --version
if [ $? -eq 0 ]
then echo \"O Java já está instalado\"

else echo \"O Java está não instalado\"
echo \"Gostaria de instalar o Java? S/n \"
read inst
if [ \"$inst\" == \"s\" ]
then
echo \"voce escolheu instalar o java\"
echo \"instalado repositorio\"
sleep 2
sudo add-apt-repository ppa:linuxuprising/java -y
clear
echo \"Atualizando repositorio\"
sleep 2
sudo apt-get update -y
clear
echo \"Para prosseguirmos com a instalacao sera necessario instalar o java 11, prosseguir com o download? S/n \"
read inst1
if [ \"$inst1\" == \"s\" ]
then
sudo apt install default-jdk -y
clear
echo \"JAVA instalado na versao 11\"
java --version
sleep 5
else echo \"você escolheu não instalar\"
break
fi
fi
fi
clear

echo \"Sera realizado agora, a instalacao do MoniSystem, nosso sistema de monitoramento\"
sleep 4
clear

echo \"Para uma instalacao completa recomendamos a criacao de um banco de dados local. Continuar com a instalacao? S/n \"
read inst2
if [ \"$inst2\" == \"s\" ]
then
sudo apt update && sudo apt upgrade -y
clear
sudo apt-get install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo docker pull mysql:5.7
sudo docker build -t cloudstax_img:1.0 .
sudo docker run -d -p 3306:3306 --name cloudstax cloudstax_img:1.0
clear
fi
