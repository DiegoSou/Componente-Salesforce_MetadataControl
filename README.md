Metadata_Controller

Controlar registros de metadados personalizados do Salesforce.
### Inclui versão em visualforce, e lwc (mais atualizada e funcional)
- Para usar
> - <p>Crie um custom metadada chamado C3C_MDT_control e armazene nele registros com o Developer Name (sem o __mdt no final) dos metadados que você deseja controlar. (é necessário criar eles caso não existam)</p>
> - <p>Precisará mudar as instâncias construídas pela classe C3C_DIContainer_Injector, nos códigos apex, para instâncias construídas a partir de new NomeClasse();</p>
> - <p>Foi construído usando adapter para comunicação com o front, são os componentes <code>call-service</code> dentro do lwc. Precisará trocar por chamadas imperativas ou com as classes APP_ </p>

<p>As mudanças para APP_ e Instâncias acima foram implementadas no Projeto Youtube, por referência </p>

<img src="https://user-images.githubusercontent.com/79648814/229036254-8f40cdd0-b982-4358-a8bf-e0158a0ba1fa.png" width="60%" height="40%"></img>



