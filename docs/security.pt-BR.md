# Política de Segurança

<p align="center">
<a href="security.md">English</a> · <a href="security.es.md">Español</a> · <strong>Português (BR)</strong>
</p>

## Versões Suportadas

O **SQL Studio** é mantido como código-fonte. A única versão suportada é a branch `main` atual: correções de segurança são aplicadas ali e não são retroportadas para commits anteriores.

## Reportando uma Vulnerabilidade

Por favor, **não** abra uma issue pública no GitHub para reportar uma vulnerabilidade de segurança.

Em vez disso, envie um e-mail para [dariomatias.dev@gmail.com](mailto:dariomatias.dev@gmail.com) contendo:

- Uma descrição da vulnerabilidade e seu impacto potencial.
- Passos para reproduzi-la (um exemplo mínimo ajuda bastante).
- O commit a partir do qual você compilou e a versão do Android em que testou.

Este é um projeto open source mantido por uma única pessoa, em escala de hobby: não há uma equipe de segurança dedicada nem um SLA formal, mas todo reporte é levado a sério e confirmado o quanto antes. Assim que uma correção for publicada, quem reportou será creditado, a menos que prefira permanecer anônimo.

## Escopo

O app funciona totalmente offline: mantém um conjunto fixo de bancos de dados de exemplo empacotados e os que o usuário criar, guarda tudo localmente (SQLite via `sqflite`, `shared_preferences`), e não faz nenhuma requisição de rede. O tipo de problema mais relevante é, portanto, local: o SQL que o próprio app executa (tanto os assets de esquema/seed empacotados quanto o divisor de instruções do console, que precisa lidar com um ponto e vírgula ou palavra-chave dentro de um literal de texto ou comentário sem interpretar mal a instrução) e como o app armazena dados no dispositivo. Problemas relacionados a servidor ou conta não se aplicam, já que não há nem servidor nem conta.
