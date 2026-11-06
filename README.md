# ProjetoHosp

Sistema hospitalar acadêmico desenvolvido em Flutter para Web, com integração ao Cloud Firestore.

## Repositório e Firebase

- Firebase Project ID: `projetohosp-eec49`
- Plataforma inicial: Web (Chrome)
- Coleção inicial: `pacientes`

## Requisitos

- Flutter SDK
- Dart SDK
- Node.js (para Firebase CLI)
- Conta Google com acesso ao projeto Firebase

## Preparar o Firebase

1. No Firebase Console, abra o projeto `projetohosp-eec49`.
2. Crie o banco em **Firestore Database**, caso ainda não exista.
3. Registre um aplicativo Web no projeto.
4. No terminal, na raiz do projeto, execute:

```bash
npm install -g firebase-tools
firebase login
dart pub global activate flutterfire_cli
flutter pub get
flutterfire configure
```

5. Selecione o projeto `projetohosp-eec49` e a plataforma **Web**. O comando gera/substitui `lib/firebase_options.dart` com as configurações reais.
6. Execute:

```bash
flutter run -d chrome
```

## Funcionalidades iniciais

- Painel inicial com navegação.
- Formulário controlado para cadastro de pacientes.
- Campos de nome, idade e telefone.
- Radio group para tipo de atendimento (enum).
- Checkbox para alergia informada.
- Gravação com `add()` na coleção `pacientes`.
- Listagem em tempo real com `StreamBuilder`.
- Tela de detalhes com passagem de dados entre páginas.
- Indicador de carregamento.

## Segurança e dados de saúde

Este repositório é uma base acadêmica, não um sistema hospitalar pronto para produção. Não cadastre dados reais de pacientes neste estágio. Dados de saúde são sensíveis. Antes de qualquer uso real, implemente autenticação, perfis de acesso, regras Firestore específicas, auditoria, política de retenção e avaliação de conformidade com a LGPD.

As regras em `firestore.rules` bloqueiam leitura e gravação por padrão. Não as substitua por regras públicas. Configure regras autenticadas e por função antes de testar gravações no Firestore.

## Banco SQL de referência

O modelo SQL Server em `database/ProjetoHosp_Modelo_Banco.sql` é uma referência de estrutura/migração. A aplicação Flutter usa Cloud Firestore como banco de dados operacional.
