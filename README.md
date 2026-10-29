# CryoContainers

Sistema acadêmico de monitoramento de temperatura para cargas transportadas em contêineres refrigerados. O projeto reúne páginas web para apresentar a solução, telas de acesso e cadastro, dashboards conceituais, uma API de aquisição de dados do Arduino e o script SQL do banco de dados.

## Objetivo

Acompanhar a temperatura de cargas refrigeradas durante o transporte, permitindo visualizar leituras e apoiar a identificação de situações em que a temperatura sai da faixa ideal para a carga.

## Funcionalidades incluídas

- **Site institucional:** apresenta a proposta, os valores e o produto CryoContainers.
- **Telas de login e cadastro:** protótipos das interfaces de acesso e registro.
- **Cadastro de carga:** interface para representar o cadastro de informações relacionadas às cargas.
- **Dashboards:** páginas de visualização geral dos contêineres e de gráficos de temperatura.
- **API de aquisição:** aplicação Node.js que recebe dados pela comunicação serial com o Arduino e disponibiliza as leituras em um endpoint HTTP.
- **Banco de dados MySQL:** estrutura para empresas, usuários, viagens, contêineres, cargas, sensores, leituras e alertas.

> **Estado do projeto:** este repositório corresponde a uma versão acadêmica em desenvolvimento. Algumas telas são protótipos visuais e nem todos os fluxos de cadastro, autenticação, alertas e dashboards estão integrados a uma API. Verifique os arquivos antes de considerar uma funcionalidade pronta para produção.

## Tecnologias

- HTML5 e CSS3
- JavaScript
- Node.js
- Express
- SerialPort
- MySQL, com o pacote `mysql2`
- Chart.js para gráficos
- Arduino e sensor de temperatura LM35 (na configuração de aquisição utilizada pelo projeto)

## Estrutura do repositório

```text
CryoContainers-SPRINT2/
├── API_dat-acqu-ino/          # API Node.js para leitura serial e envio de dados
│   ├── main.js
│   ├── index.html              # Exemplo de gráfico das leituras da API
│   └── package.json
├── SITE/
│   ├── Site_Institucional/     # Página institucional
│   ├── Site_Dash/              # Dashboard de temperatura
│   ├── Site_Dash_Geral/        # Visão geral dos contêineres
│   ├── Tela_Login/             # Interface de login
│   ├── Tela_Cadastro/          # Interface de cadastro de usuário/empresa
│   └── Tela_Cadastro_Carga/    # Interface de cadastro de carga
└── BancoDeDados.sql            # Criação do banco MONITORAMENTO e suas tabelas
```

## Como executar

### 1. Banco de dados

1. Instale e inicie o MySQL Server.
2. Abra o arquivo `BancoDeDados.sql` em uma ferramenta como MySQL Workbench.
3. Execute o script para criar o banco `MONITORAMENTO`, as tabelas e o usuário de inserção.
4. Confira se a porta, o usuário e as permissões estão de acordo com sua instalação.

**Importante:** a configuração atual da API utiliza `127.0.0.1`, banco `MONITORAMENTO` e porta `3307`. Ela também contém credenciais definidas diretamente no código. Antes de executar, ajuste as configurações em `API_dat-acqu-ino/main.js` para o seu ambiente e não publique senhas reais em repositórios públicos.

### 2. API Arduino

É necessário ter Node.js e npm instalados, o Arduino conectado e o banco de dados configurado.

No terminal, entre na pasta da API:

```bash
cd API_dat-acqu-ino
npm install
npm start
```

Por padrão, a API inicia na porta **3300**. O endpoint disponível para consultar as leituras analógicas é:

```text
http://localhost:3300/sensores/analogico
```

A API procura automaticamente uma porta serial com os identificadores de fabricante e produto definidos no código. O Arduino deve enviar leituras em linhas terminadas por quebra de linha; o código interpreta o primeiro valor separado por `;` como temperatura.

A inserção no banco está habilitada por padrão em `main.js`. Para alterar esse comportamento, ajuste a constante `HABILITAR_OPERACAO_INSERIR` e confira se a tabela e as credenciais correspondem ao seu banco.

### 3. Site e dashboards

As páginas da pasta `SITE` são arquivos HTML, CSS e JavaScript. Para visualizar as interfaces, abra os arquivos HTML no navegador ou utilize a extensão **Live Server** no Visual Studio Code.

Para a API funcionar junto das páginas, mantenha a API em execução e confirme se o endereço utilizado no JavaScript corresponde ao ambiente em que ela está rodando. O endereço `localhost` só funciona na própria máquina; em uma arquitetura com computadores diferentes, será necessário configurar o IP ou hostname do computador que hospeda a API.

## Fluxo geral dos dados

1. O sensor conectado ao Arduino mede a temperatura.
2. O Arduino envia os valores pela comunicação serial.
3. A API Node.js lê e interpreta os dados recebidos.
4. Quando a inserção está habilitada, a API grava a leitura na tabela `leitura_sensor` do MySQL.
5. A API também disponibiliza os valores recebidos pelo endpoint `/sensores/analogico`, que pode ser consultado por uma página web.

## Banco de dados

O script `BancoDeDados.sql` cria o banco `MONITORAMENTO`, com tabelas relacionadas a:

- empresas e usuários;
- viagens e contêineres;
- cargas e sensores;
- leituras de temperatura;
- tipos de alerta e alertas.

As tabelas utilizam chaves primárias e estrangeiras para representar os relacionamentos entre esses dados.

## Observações

- A API possui configurações de porta serial e banco de dados que podem precisar de ajustes conforme o computador e o hardware utilizados.
- Os gráficos e as páginas web dependem da integração e dos endereços configurados no código.
- Não utilize credenciais de exemplo em ambientes reais. Configure permissões mínimas e mantenha senhas fora do código-fonte.
- Este projeto tem finalidade acadêmica e pode exigir ajustes, testes e integração adicional antes de uso operacional.

## Equipe

Projeto desenvolvido em contexto acadêmico na **São Paulo Tech School (SPTech)**.

---
