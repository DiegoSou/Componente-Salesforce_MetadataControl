Metadata_Controller

Controlar registros de metadados personalizados do Salesforce.
### Inclui versão em visualforce e lwc (mais atualizada e funcional)
- Para usar
> - Crie um custom metadada chamado C3C_MDT_control e armazene nele registros com o Developer Name dos metadados que você deseja controlar. (é necessário criar eles caso não existam)
> - Precisará mudar as instâncias construídas pela classe C3C_DIContainer_Injector, nos códigos apex, para instâncias construídas a partir de new NomeClasse();
> - Foi construído usando adapter para comunicação com o front, são os componentes <call-service> dentro do lwc. Precisará trocar por chamadas imperativas ou o modelo APP_ (está em outro projeto).

