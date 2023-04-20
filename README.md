Metadata_Controller

Controlar registros de metadados personalizados do Salesforce.

- Para usar
<<<<<<< HEAD
> - <p>Crie um custom metadada chamado C3C_MDT_control e criar nele registros com o Developer Name (sem o __mdt no final) dos metadados que você deseja controlar. (é necessário criar os objetos dos metadados caso eles não existam)</p>
> - <p> Colocar o componente lwc "configureMdt" na utilitybar dos aplicativos do lightning ( Criador de aplicativo do Lightning | Gerenciador de Aplicativos | Seleciona "Editar" para o aplicativo | Itens de utilitários)</p>
> - <p> Para campos de data, utilizar data/hora (datetime) para o tipo do campo no metadado </p>
=======
> - <p>Crie um custom metadada chamado C3C_MDT_controls e armazene nele registros com o Developer Name (sem o __mdt no final) dos metadados que você deseja controlar. (é necessário criar eles caso não existam)</p>
> - <p>Foi construído usando adapter para comunicação com o front, são os componentes <code>call-service</code> dentro do lwc. Precisará trocar por chamadas imperativas ou com as classes APP_ </p>

<p>As mudanças para APP_ e Instâncias acima foram implementadas no Projeto Youtube, por referência </p>
>>>>>>> refs/remotes/origin/master

<img src="https://user-images.githubusercontent.com/79648814/229036254-8f40cdd0-b982-4358-a8bf-e0158a0ba1fa.png" width="80%" height="50%"></img>



