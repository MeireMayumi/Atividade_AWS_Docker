# Atividade AWS - Docker | UNICESUMAR Turma 2

**Arquitetura do projeto:**

![Arquitetura_projeto](https://github.com/MeireMayumi/aws_docker/assets/167933389/4775b87c-8b40-40e7-ad3b-c0e99836d5a0)




<details>
<summary>Descrição da atividade</summary>

1. Instalação e configuração do DOCKER ou CONTAINERD no host EC2;
- Ponto adicional para o trabalho: utilizar a instalação via script de Start Instance [user_data.sh](https://github.com/MeireMayumi/aws_docker/blob/main/user_data.sh)
2. Efetuar Deploy de uma aplicação Wordpress com: container de aplicação RDS database Mysql
3. Configuração da utilização do serviço EFS AWS para estáticos do container de aplicação Wordpress
4. Configuração do serviço de Load Balancer AWS para a aplicação Wordpress
</details>

<details>
<summary>Pontos de atenção</summary>

- Não utilizar ip público para saída do serviços WP (Evitem publicar o serviço WP via IP Público)
- Sugestão para o tráfego de internet sair pelo LB (Load Balancer Classic)
- Pastas públicas e estáticos do wordpress sugestão de utilizar o EFS (Elastic File Sistem)
- Fica a critério de cada integrante usar Dockerfile ou Dockercompose;
- Necessário demonstrar a aplicação wordpress funcionando (tela de login)
- Aplicação Wordpress precisa estar rodando na porta 80 ou 8080;
  
</details>

 - ###  [Atividade AWS - Docker](https://github.com/MeireMayumi/aws_docker/blob/main/Atividade_AWS_Docker.md)






