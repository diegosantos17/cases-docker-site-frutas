# cases-docker-site-frutas
Case utilizando containers distintos para Node, Mysql e PHP
<br><br>

# referências
- https://youtu.be/Kzcz-EVKBEQ
- Problema de conexão do mysql:https://stackoverflow.com/questions/50093144/mysql-8-0-client-does-not-support-authentication-protocol-requested-by-server
<br><br>

# mysql

## comandos
> Baixando imagem do mysql a partir de um Dockerfile <br>
    <code>
    docker build -t mysql-image -f api/db/Dockerfile .
    </code>

> Criando o container a partir da imagem baixada <br>
    <code>
    docker run -d --rm --name mysql-container mysql-image
    </code>

> Criando e populando a base de dados <br>
    <code>
    docker exec -i mysql-container mysql -uroot -proot < api/db/script.sql
    </code>

> Acessando container do mysql e validando a criação do banco <br>
    <code>
    docker exec -it mysql-container /bin/bash
    </code>
    <br>
    <code>
    mysql -uroot -proot
    </code>
    <br>
    <code>
    use db_site_frutas
    </code>
    <br>
    <code>
    select * from products;
    </code>

> Recriando o container a partir da imagem baixada e compartilhando volume, evitando perder tudo quando banco for recriado <br>
    <code>
    docker run -d -v /var/lib/mysql:/var/lib/mysql --rm --name mysql-container mysql-image 
    </code>
<br><br>

# node (api)

## comandos
> sudo apt install npm <br>
> sudo apt install nodejs <br>
> npm install --save-dev nodemon <br>
> npm install --save express mysql <br>

## contruindo o container
Executar o comando na raiz do projeto
> docker build -t node-image -f api/Dockerfile .

Rodando imagem dentro de um container
> docker run -d -v $(pwd)/api:/home/node/app -p 9001:9001 --link mysql-container --rm --name node-container node-image

Exibindo resultado
> acessar localhost:9001
## glossário node
- nodemon: manterá o node rodando e o atualizará sempre que houver alteração no javascript

# php (website)

## comandos
Na raix do projeto (acima da pasta website) rodar:
> docker build -t php-image -f website/Dockerfile 

> docker run -d -v $(pwd)/website:/var/www/html -p 8888:80 --link node-container --rm --name php-container php-image .

Exibindo resultado
> acessar localhost:8888

# recomendações de extensões vscode
- gitlens vscode
- version Lens
- gitignore
- git graph
- node require
- express snippets
<br><br>

# recomendações de extensões chrome
- JSON Viewer: https://chrome.google.com/webstore/detail/json-viewer/gbmdgpbipfallnflgajpaliibnhdgobh/related?hl=pt-BR

# glossário docker
- -t: tag = Nome da imagem local para identificá-la
- -d: detach = Libera a aba para uso, do contrário ficará indisponível
- --rm: remove = Se o container já existir será removido 
- --name = Nome do container
- exec = Significa que executaremos um comando dentro de um container
- -i = Executando um comando no modo interativo
- -it = O t significa que utilizaremos o TTYm que em resumo é o terminal
- -v: volume = Compartilhando o volume, sendo host:container (volumes separados por 2 pontos)
- -f:file = arquivo, nesse caso, Dockerfile de referência
- -p:port= flag port, que diz qual porta no host espelhará a porta do container (esquerda host, direita container)
- --link= com essa flag, é possível ao invés de utilizar o IP da máquina, utilizar o seu name
- docker inspect container-name = exibe detalhes do container, como IP, rede, etc
- WORDIR= onde está localizada a aplicação
- CMD= comando a ser executado assim que o container subir
<br><br>

# Imagens Docker Utilizadas
- https://hub.docker.com/_/mysql
- https://hub.docker.com/_/node
- https://hub.docker.com/_/php

# Dockercompose
- podemos, ou não, usar um Dockerfile
- volumes = mapeamento que substituí -v no docker run
- build = Se usarmos o Dockerfile (com esse nome), não precisamos mencionar o comaminho completo com o nome, do contrário sim.
- Se o nome do arquivo não for docker file, teria que usar<br>
    <pre>
        api:
            build:
                context: "./api"
                dockerfile: "Dockerfile-XPTO

    </pre>
- restart = caso o container caia, ele será reiniciado automáticamente 

