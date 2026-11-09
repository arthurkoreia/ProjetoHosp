
# ProjetoHosp

**NP2 - Desenvolvimento Mobile | Flutter / Dart (Web) | Firebase / Cloud Firestore**

## Aplicativo e objetivo

O ProjetoHosp é um protótipo acadêmico de gestão hospitalar para organizar o cadastro e a consulta de pacientes fictícios. O objetivo é evitar informações dispersas e retrabalho, oferecendo um fluxo simples para registrar e consultar dados na nuvem. Consultas, atendimentos e relatórios são possibilidades de evolução apresentadas nos slides, não funcionalidades confirmadas no código.

## Funcionalidades do protótipo

- **Painel:** atalhos para cadastrar e consultar pacientes.
- **Cadastro:** nome, idade, telefone, atendimento (SUS, convênio ou particular), alergia informada e validação dos dados.
- **Dados e consulta:** gravação prevista na coleção `pacientes` do Cloud Firestore com `add()`; listagem com `snapshots()` e `StreamBuilder`, carregamento e tela de detalhes via `Navigator`.

## Tecnologias e dados do projeto

- **Plataforma e armazenamento:** Flutter e Dart para Web (Chrome), com Firebase Cloud Firestore.

## Integrantes e divisão de funções

- **Wictor Bazoni - R196070:** Coordenação, organização das entregas e apresentação.
- **Pedro Miranda - F363FJ8:** Desenvolvimento da parte do recurso adicional (VLibras).
- **Arthur Finarde - H75GFI2:** Integração com Firebase, listagem e testes dos dados.
- **Laura Lima - R816567:** Desenvolvimento da apresentação e dos slides.
- **Gabriel Salazar - R668CH5:** Navegação, formulários e validação dos campos.

## Recurso adicional - VLibras (UX e inclusão digital)

**Escolha:** VLibras Widget, ferramenta gratuita do Governo Federal que traduz textos em português para Libras por meio de um avatar virtual. A proposta é tornar a interface mais acessível, facilitar a compreensão do conteúdo e ampliar a autonomia de pessoas surdas usuárias de Libras. O recurso complementa, mas não substitui intérpretes humanos ou outras medidas de acessibilidade.

## Fontes

- [Governo Federal - Suíte VLibras](https://www.gov.br/governodigital/pt-br/acessibilidade-e-usuario/vlibras)
- [VLibras - Manual oficial de integração do Widget para Web](https://vlibras.gov.br/doc/widget/installation/webpageintegration.html)

