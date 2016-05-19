#! /bin/bash

# # # Licenciado sob a GPL, portanto sinta-se a vontade para modificar, usar ou esudar se baseando neste script
# # # Versão 3.0 (stable)
# # # Autoria: José Afonso da Silva Carvalho
# # # Contribuições: Henrique Rodrigues, Caio Ceccon
# # # Referências : Livro e Site de Julio Neves
# #
# # # CONTRIBUIÇÃO mais que IMPORTANTE!!!: Henrique Rodrigues
# # # responsável por debugar o script todo... muito obrigado!!
# #
# # # este script é orientado as necessidades específicas da empresa --------,
# # # apos a instalação do Ubuntu base pela rede, execute este script para a criação de usuários
# # # padrão, instalação dos programas necessários e outras tarefas

# # # __________________________________________________________________
# # #                              FUNÇÕES
# # # __________________________________________________________________

alias_on_users() {

for i in `ls /home`
do
echo 'alias sucata="rdesktop -K -T sucata -u suporte [ip ou endereço do servidor]"' >> /home/$i/.bashrc
done

}

alias_on_skel() {
echo 'alias sucata="rdesktop -K -T sucata -u suporte [ip ou endereco do servidor]"' >> /etc/skel/.bashrc
}

remotefinan() {
for i in `ls /home`
do
echo 'alias fin="rdesktop -K -T financeiro -u finan [ip ou endereço do servidor]"' >> /home/$i/.bashrc
done
}


addusers_extras(){
adduser suporte --gecos suporte --disabled-password
adduser $USErnAME --gecos $USErnAME --disabled-password
}

extOpt() {
echo "Digite:
a - Para instalar ferramentas de desenvolvimento (Quanta, KDevelop, Eclipse)
b - Para NÃO instalar ferramentas de desenvolvimento"
}

mAin() {
echo -e '\033[44;37;1m
...........................................
.=========================================.
.Autor:   José Afonso                     .
.Co-autor:   Henrique Rodrigues           .
.Versão 2.3.0                             .
...........................................
+++++++++++++++++++++++++++++++++++++++++++
========= Script de configuração ==========
___________________________________________

                  :::         :::
                 :::         :::
                :::         :::
               :::::::::::::::
              :::::::::::::::
             :::         :::
            :::         :::
           :::         :::
__________________________________________

\033[m'
sleep 5
reset

}

xubuntu_install(){
apt-get install -y xubuntu-desktop kubuntu-restricted-extras ubuntu-restricted-extras gftp rdesktop openssh-server thunderbird whois
}

suporte_install(){
apt-get install -y ubuntu-restricted-extras kubuntu-restricted-extras twinkle mysql-client mysql-query-browser mysql-admin gftp kate konqueror rdesktop openssh-server thunderbird whois traceroute
}

suporte_install_ubuntu(){
apt-get install -y ubuntu-desktop ubuntu-restricted-extras kubuntu-restricted-extras twinkle mysql-client mysql-query-browser mysql-admin  gftp kate konqueror rdesktop openssh-server thunderbird whois
}

comercial_install(){
apt-get install -y ubuntu-restricted-extras kubuntu-restricted-extras twinkle mysql-client gftp kate konqueror rdesktop openssh-server thunderbird whois
}

financeiro_install(){
apt-get install -y ubuntu-desktop ubuntu-restricted-extras twinkle smbfs gftp rdesktop openssh-server whois
}

create_suporte(){
mAin

hOst

alias_on_skel

suporte_install

skypeinstall

googlenavigator

  echo -e
'--------------------------------------------
 Sistema pronto para uso no setor "Suporte".
 AVISO! este sistema É compatível com o setor
 "Comercial/Qualidade",
 sem necessidade de alterações importantes
 --------------------------------------------'

  sleep 5
reboot
}

create_suporte_ubuntu(){

hOst

alias_on_skel

suporte_install_ubuntu

skypeinstall

googlenavigator


  echo -e '--------------------------------------------
  Sistema pronto para uso no setor "Suporte".
  AVISO! este sistema É compatível com o setor "Comercial/Qualidade",
  sem necessidade de alterações importantes
  ----------------------------------------------'

  sleep 5
reboot
}

create_comercial(){
hOst

alias_on_skel

comercial_install

skypeinstall

echo -e '--------------------------------------------
Sistema pronto para uso no setor "Comercial/Qualidade".
AVISO! este sistema É compatível com o setor "Suporte",
 sem necessidade de alterações importantes
----------------------------------------------'
sleep 5
exit
}

create_financeiro(){
mAin
# função do hostname
hOst

# usa a função alias_on_skel no lugar do for
alias_on_skel

financeiro_install

skypeinstall

smb_finac_server

smb_finac_serverold


echo -e '--------------------------------------------
Sistema pronto para uso no setor "Comercial/Qualidade".
AVISO! este sistema É incompatível com os setores "Suporte" e "Comercial/Qualidade"
sem necessidade de alterações importantes.
(Necessita instalação de alguns programas e remoção do acesso ao financeiro)
----------------------------------------------'

sleep 5
exit
}

gconffunction_VNC(){
  gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /desktop/gnome/remote_access/enabled true
  gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type string --set /desktop/gnome/remote_access/icon_visibility never
  gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /desktop/gnome/remote_access/prompt_enabled false
  gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type string --set /desktop/gnome/remote_access/authentication_methods vnc
  gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type string --set /desktop/gnome/remote_access/vnc_password OTUxNzUz
  gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /desktop/gnome/remote_access/disable_xdamage true
  gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /desktop/gnome/remote_access/disable_background true
}

gconffunction_IFC(){
  gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /desktop/gnome/interface/accessibility false
  gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /desktop/gnome/accessibility/keyboard/mousekeys_enabled false
}

hOst() {
read -p "Digite o hostname deste pc:" HOSTnAME
echo $HOSTnAME > /etc/hostname
echo "Reinicie o pc para queas mudanças tenham efeito"
}

skypeblok() {
chmod -x /usr/bin/skype
}

skypeinstall() {
if [ -f skype*.deb ]
then
dpkg -i skype-debian*.deb
else
echo "Por favor verifique se há o arquivo de instalação em /home/hostnet"
fi
}

googlenavigator() {
if [ -f google-chrome*.deb ]
then
dpkg -i google-chrome*.deb
else
echo "Por favor verifique se há o arquivo de instalação em /home/hostnet"
fi
}

smb_finac_serverold() {
echo '//blue/Financeiro /mnt/finac smbfs username=financeiro,password=dinheiro,uid=1001,gid=1001,noatime 0 0' >> /etc/fstab
}

smb_finac_server() {
read -p "Usuário que terá acesso:" userName
GUID=($(cat /etc/passwd | fgrep $userName | cut -f3-4 -d":" | tr : ' '))
echo "//financeiro/Financeiro /mnt/finac2 smbfs username=finan2,password=finan2,uid=${GUID[0]},gid=${GUID[1]},noatime 0 0" >> /etc/fstab
mkdir /mnt/finac2
}

# # # __________________________________________________________________
# # #                              Script
# # # __________________________________________________________________


case $1 in # caso o primeiro parametro seja:

a) # Suporte
create_suporte
;;

U)  # Suporte
create_suporte_ubuntu
;;

b)  # Comercial
create_comercial
;;

c) # Financeiro
create_financeiro
;;

d) # Kubuntu (opções extras)
mAin

extOpt

read InstaLl
clear
read -p "Digite o nome de usuário:" USErnAME

addusers_extras

skypeinstall

googlenavigator

  case $InstaLl in # Opções de instalação
  a) # com quanta, kdevelop, eclipse
  apt-get install -y kubuntu-desktop ubuntu-restricted-extras kubuntu-restricted-extras unrar gftp rdesktop openssh-server thunderbird whois eclipse quanta kdevelop


  ;;
  b) # sem ferramentas extras
  apt-get install -y kubuntu-desktop ubuntu-restricted-extras kubuntu-restricted-extras unrar gftp rdesktop openssh-server thunderbird whois


  ;;
  *) # erro
  echo 'Não é assim! use "a" ou "b"'
  ;;
  esac
;;

e) # Ubuntu (opções extras)
mAin

extOpt

read InstaLl
clear
read -p "Digite o nome de usuário:" USErnAME

addusers_extras

skypeinstall

googlenavigator

  case $InstalL in # Opções de instalação
  a) # com ferramentas de desenvolvimento
  apt-get install -y ubuntu-desktop ubuntu-restricted-extras kubuntu-restricted-extras unrar gftp rdesktop openssh-server thunderbird whois eclipse quanta kdevelop


  ;;
  b) # sem ferramentas de desenvolvimento
  apt-get install -y ubuntu-desktop ubuntu-restricted-extras kubuntu-restricted-extras unrar gftp rdesktop openssh-server thunderbird whois

  ;;
  *) # erro
  echo 'Não é assim! use "a" ou "b"'
  ;;
  esac
;;

f) # Xubuntu
mAin

read -p "Digite o nome de usuário:" USErnAME

addusers_extras

xubuntu_install

skypeinstall

googlenavigator
;;

S) # instala Skype
skypeinstall
;;

G) # instala o navegador Google-Chrome
googlenavigator
;;

H) # altera hostname
hOst
;;

F) # executa a função gconffunction_VNC para configurar automáticamente o VNC
gconffunction_VNC
;;

O) # instala o navegador opera
dpkg -i opera*.deb
;;

T) # executa a função alias_on_users que tenta configurar automaticamente os alias em todos os usuários
alias_on_users
;;

*) # Parametro errado!
echo "AJUDA -> Uso : $0 <parametro>
Lista de parametros aceitos
a - Suporte
b - Comercial
c - Financeiro
d - Outros (Kubuntu)
e - Outros (Ubuntu)
f - Outros (Xubuntu)
S - instala Skype
G - instala o Google-Chrome
H - altera o hostname
F - Configura automaticamente o acesso remoto
T - Configura os alias no pós-instalação (sucata)
U - para instalação do ubuntu-desktop COM o script
__________________________________________________________________
  Exemplo de instalação no Suporte:
    maquina@localhost:/home/hostnet# $0 a
  OU
    maquina@localhost:~$ $0 a
sendo recomendável o uso de <sudo su> para se tornar root e usar e
não correr o risco de erros de permissão"

;;

esac
