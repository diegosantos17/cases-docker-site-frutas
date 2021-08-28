# cases-docker-site-frutas
Case utilizando containers distintos para Node, Mysql e PHP
<br><br>

# referências
https://youtu.be/Kzcz-EVKBEQ
<br><br>

# comandos
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
# glossário
- -t: tag = Nome da imagem local para identificá-la
- -d: detach = Libera a aba para uso, do contrário ficará indisponível
- --rm: remove = Se o container já existir será removido 
- --name = Nome do container
- exec = Significa que executaremos um comando dentro de um container
- -i = Executando um comando no modo interativo
- -it = O t significa que utilizaremos o TTYm que em resumo é o terminal
- -v: volume = Compartilhando o volume, sendo host:container (volumes separados por 2 pontos)