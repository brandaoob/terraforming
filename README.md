# Infraestrutura de Servidores e Buckets S3 com Terraform

Este repositório contém a configuração de infraestrutura utilizando Terraform, que cria servidores EC2 e buckets S3 para diferentes ambientes (`dev` e `prod`), além de aplicar controle de propriedade e ACL nos buckets.

## Estrutura de Diretórios

A estrutura do projeto é organizada da seguinte forma:

.
├── bucket/
│   ├── buckets.tf           # Recursos de buckets S3
│   ├── vars.tf              # Variáveis para os buckets
├── ec2/
│   ├── instances.tf         # Recursos de instâncias EC2
│   ├── vars.tf              # Variáveis para instâncias EC2
├── servers/                 # Configurações dos servidores em YAML
│   ├── dev.yaml             # Servidores para ambiente de desenvolvimento
│   ├── prd.yaml             # Servidores para ambiente de produção
├── main.tf                  # Módulos principais (buckets, ec2)
├── provider.tf              # Configuração do provedor AWS
├── locals.tf                # Definição de variáveis locais
├── Makefile                 # Automação com Make
└── .env.example             # Exemplo de variáveis de ambiente AWS

## O que esse código faz

### **Buckets S3**

O código cria buckets S3 para armazenar dados nos seguintes ambientes:

- **dev** (desenvolvimento)
- **prod** (produção)

Para cada bucket, são configuradas as permissões de ACL para garantir que o acesso seja privado e a propriedade do objeto seja controlada pelo proprietário do bucket.

### **Instâncias EC2**

Com base nos arquivos YAML em `servers/`, são criadas instâncias EC2 com configurações diferentes para os ambientes:

- **dev**: 1 instância tipo `t3.nano`
- **prd**: 6 instâncias (3 de `t3.small` e 3 de `t3.micro`)

O número de instâncias e os tipos podem ser configurados diretamente nos arquivos YAML.

## Pré-requisitos

Antes de aplicar as configurações, você precisa:

- Ter uma conta AWS configurada com as credenciais apropriadas.
- Instalar o [Terraform](https://www.terraform.io/downloads).
- Configurar suas credenciais AWS, criando um arquivo `.env` com suas chaves de acesso:

export AWS_ACCESS_KEY_ID="sua_chave_de_acesso"
export AWS_SECRET_KEY="sua_chave_secreta"

## Como aplicar

### Passo 1: Preparar o ambiente

Clone este repositório:

git clone https://seu-repositorio.git
cd seu-repositorio

Copie o arquivo `.env.example` para `.env` e adicione suas credenciais AWS.

### Passo 2: Inicializar o Terraform

Execute o comando abaixo para inicializar o Terraform e baixar os provedores necessários:

terraform init

### Passo 3: Planejar e aplicar a infraestrutura

Você pode usar o Makefile para simplificar os comandos do Terraform. Para aplicar o plano, siga os seguintes passos:

1. **Criar o plano de execução** (substitua `NAME` por `dev` ou `prd`):

   make plan NAME=dev

2. **Aplicar o plano**:

   make apply NAME=dev

   Isso criará a infraestrutura definida no Terraform para o ambiente especificado.

### Passo 4: Limpeza

Após a aplicação, você pode limpar os planos gerados pelo Terraform:

make clear-plans

Isso remove os arquivos de plano gerados, como `plan_dev` e `plan_prd`.

## Variáveis

### **Bucket**

No arquivo `bucket/vars.tf`, a variável `buckets` define os buckets a serem criados. Exemplo:

variable "buckets" {
  type        = list(string)
  default     = ["documents", "images", "users"]
  description = "buckets names list"
}

### **EC2**

As variáveis de instâncias EC2 estão definidas em `ec2/vars.tf` e são passadas para o módulo `ec2` a partir do arquivo `locals.tf`.

### **Arquivos YAML**

Os arquivos `servers/dev.yaml` e `servers/prd.yaml` contêm as configurações dos servidores para os ambientes de desenvolvimento e produção, respectivamente. Cada arquivo YAML define um ambiente com informações sobre o nome, tipo e quantidade de servidores:

environment: dev
servers:
  - name: app
    size: 1
    type: t3.nano

## Observações

- Os buckets S3 são configurados com controle de propriedade e ACL privada para garantir que os dados estejam protegidos.
- As instâncias EC2 são criadas com base nas configurações fornecidas nos arquivos YAML.
  
## Contribuindo

1. Faça um fork deste repositório.
2. Crie uma branch (`git checkout -b feature-nome-da-sua-feature`).
3. Faça suas alterações e commit (`git commit -am 'Adicionar nova feature'`).
4. Envie para o repositório remoto (`git push origin feature-nome-da-sua-feature`).
5. Abra um pull request.


