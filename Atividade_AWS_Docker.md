# Atividade AWS e Docker

## - Serviços RDS
#### Acessar o serviço de RDS no console da AWS:
<details>
<summary>Criação do RDS</summary>
  
1) Clicar em `Criar banco de dados`;
2) Em `Opções de mecanismo` selecionar "MySQL", em `Opções de modelos` selecionar o nível gratuito, configurar a instância do banco de dados preenchendo o nome, o usuário principal e senha, em `grupo de segurança da VPC` dentro de `conectividade` configurar o grupo de segurança para permitir tráfego na porta 3306 do grupo de segurança da instância privada;
3) Clicar em `Criar banco de dados`.

</details>


## - Serviços VPC
#### Acessar o serviço de VPC no console da AWS:
<details>
<summary>Criação da VPC</summary>

1) Clicar em `Criar VPC`;
2) Informar um bloco de IPv4 válido e IPv6, se aplicável;
3) Criar 2 sub-redes privadas e 2 sub-redes públicas e alocar uma de cada tipo em duas zonas de disponibilidade diferentes;
4) No campo de Opções de DNS, habilitar os "nomes de host DNS" e "resolução de DNS";
5) Clicar em `Criar VPC`.
</details>

<details>
<summary>Criação de Internet Gateway</summary>

1) Em `Gateways da Internet`, clicar em `Criar gateway da Internet`;
2) Nomear e clicar em `Criar gateway da Internet`.  
</details>

<details>
<summary>Criação de Gateway NAT</summary>

1) Em `Gateways NAT`, clicar em `Criar gateway NAT`;
2) Nomear, associar a uma sub-rede pública, selecionar o tipo de conectividade público e alocar um IP elástico;
3) Clicar em `Criar gateway NAT`.
</details>

<details>
<summary>Configuração da tabela de roteamento</summary>

1) Criar uma tabela de rotas para as 2 sub-redes públicas e uma para as 2 sub-redes privadas;
2) Em `Tabelas de rotas` e clicar em `Criar tabela de rotas`;
3) Nomear a tabela e escolher a VPC que foi criada anteriormente;
4) Clicar em `Criar tabela de rotas`.

#### Associar as sub-redes às tabelas:

1) Selecionar a tabela de rotas da sub-rede privada, em 
`Associações de sub-rede` clicar em `Editar associações de sub-rede` e adicionar as 2 sub-redes privadas.
2) Fazer o mesmo com a tabela de rotas das sub-redes públicas.

#### Associar o gateway da Internet à Tabela de rotas pública:

1) Selecionar a tabela de rotas pública, na parte de `Rotas` clicar em `Editar rotas`;
2) Clicar em `Adicionar rota`, com destino "0.0.0.0/0" e selecionar como "Alvo" o gateway da Internet criado anteriormente e salvar.

#### Associar o gateway NAT à Tabela de rotas privada:

1) Selecionar a tabela de rotas privada, na parte de `Rotas` clicar em `Editar rotas`;
2) Clicar em "Adicionar rota", com destino "0.0.0.0/0" e selecionar como "Alvo" o gateway NAT criado anteriormente e salvar.
</details>

## - Serviços EFS
#### Acessar o serviço de EFS no console da AWS:
<details>
<summary>Criação do EFS</summary>

1) Clicar em `Criar sistema de arquivos`;
2) Nomear e atribuir à VPC criada anteriormente;
3) Clicar em `Criar sistema de arquivos`.
</details>

## - Serviços EC2
#### Acessar o serviço de EC2 no console da AWS:

<details>
<summary>Criação do Elastic Load Balancer</summary>

1) Em `Load balancers` clicar em `Criar load balancer`;
2) Criar um "Application Load Balancer";
3) Nomear, selecionar o esquema voltado para a Internet, escolher o tipo de endereço IP aplicável, selecionar a VPC criada anteriormente, para o mapeamento escolher ao menos duas zonas de disponibilidade, configurar o Grupo de Segurança para permitir conexões HTTP e HTTPS com origem "0.0.0.0/0" e selecionar para "Listener" o protocolo HTTP, porta 80;
4) Clicar em `Criar load balancer`.
</details>

<details>
<summary>Criação de Bastion Host</summary>

1) Clicar em `Executar instâncias`;
2) A imagem utilizada foi a "Amazon Linux 2", tipo de instância "t2.micro";
3) Em `configurações de rede`, selecionar a VPC criada, utilizar uma sub-rede _pública_ e configurar o grupo de segurança para permitir somente o tráfego SSH de "meu IP" ;
4) Utilizar o armazenamento padrão e clicar em `Executar instância`.
</details>

<details>
<summary>Criação de Instância privada</summary>

1) Clicar em `Executar instâncias`;
2) A imagem utilizada foi a "Amazon Linux 2", tipo de instância "t2.micro";
3) Em `configurações de rede`, selecionar a VPC criada, utilizar uma sub-rede _privada_ e configurar o grupo de segurança para permitir o tráfego SSH somente do IP privado do Bastion host e as portas 80 e 443 (HHTP e HTTPS, respectivamente) para o grupo de segurança do Load Balancer;
4) Utilizar o armazenamento padrão;
5) Em `Detalhes avançados`, selecionar o arquivo [user_data.sh](https://github.com/MeireMayumi/Atividade_AWS_Docker/blob/main/user_data.sh) no campo `Dados do usuário`, para configurar a instalação do Docker, montagem do EFS e execução do docker-compose para o deploy do Wordpress utilizando o RDS, durante a inicialização da instância.
6) Clicar em `Executar instância`.
</details>

<details>
<summary>Criação do Grupo de Destino</summary>

1) Em `Grupos de destino`, clicar em `Criar grupo de destino`;
2) Selecionar "instâncias" como tipo de destino, nomear o grupo, selecionar como protocolo o HTTP: porta 80, selecionar o tipo de endereço IP aplicável, selecionar a VPC criada anteriormente, utilizar como versão do protocolo o "HTTP1", configurar protocolo HTTP com caminho "/" para verificações de integridade;
3) Clicar em `Próximo`;
4) Registrar destinos incluindo no grupo de destino a instância privada que foi criada anteriormente;
5) Clicar em `Criar grupo de destino`.
</details>

<details>
<summary>Criação de Modelo de Execução</summary>

1) Em `Instâncias`, com o botaõ direito, clicar na instância privada criada anteriormente e clicar em `Imagem e Modelos` e `Criar modelo a partir da Instância`;
2) Nomear o modelo e adicionar uma breve descrição;
3) O restante das opções estarão selecionadas conforme a instância privada;
4) Clicar em `Criar modelo de execução`.
</details>

<details>
<summary>Criação do Grupo de Auto Scaling</summary>

1) Em `Grupos Auto Scaling`, clicar em `Criar Grupo do Auto Scaling`;
2) Nomear e selecionar o modelo de execução criado anteriormente;
3) Em `Rede` selecionar a VPC criada e selecionar as 2 sub-redes privadas;
4) Selecionar o balanceador de carga que foi criado e deixar as outras configurações padrões;
5) Selecionar a opção `Escolha entre seus grupos de destino de balanceador de carga` e adicione o grupo de destino criado anteriormente; 
6) Preencher a capacidade desejada com a quantidade de instâncias que deseja que fique executando, configure o limite de ajuste de escala, preenchendo a quantidade mínima e máxima de instâncias a serem escaladas e selecione a política de dimensionamento para ajuste de escala automática que deseja;
7) Se desejar adicione notificações e etiquetas;
8) Clicar em `Criar grupo do Auto Scaling`.
</details>

## - Conclusão

- O projeto mostrou como diferentes serviços da AWS podem ser integrados para fornecer um ambiente completo para hospedar aplicativos como o WordPress usando contêineres;
- Foi possível criar uma infraestrutura AWS para hospedar o Wordpress, utilizando o Docker, serviço de RDS para banco de dados e EFS para armazenamento e compartilhamento de arquivos;
- Foram utilizadas instâncias em sub-redes privadas, permitindo acesso SSH somente ao IP privado do bastion host e acesso HTTP e HTTPS somente ao load balancer e um bastion host permitindo acesso SSH somente ao meu IP;
-  Foi utilizado um arquivo "[user_data.sh](https://github.com/MeireMayumi/Atividade_AWS_Docker/blob/main/user_data.sh)" para configurar a instalação do Docker, a montagem do EFS e execução do docker-compose ao iniciar a instância;
- A utilização de Auto Scaling e Load Balancer garantem alta disponibilidade e escalabilidade do serviço;
- O acesso ao Wordpress foi realizado através do DNS do load balancer.




