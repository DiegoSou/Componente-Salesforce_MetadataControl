import { LightningElement, track } from 'lwc';

const columns = 
[
    {editable : true, label : 'Label', fieldName : 'masterLabel' }, 
    {editable : true, label : 'Classe Apex', fieldName : 'nomeClasse' }, 
    {editable : true, label : 'Estático', fieldName : 'estatico', type : 'boolean' }
];

export default class LwcBindings extends LightningElement 
{   
    dataMap;                  // Mapa de todos os registros
    columns = columns;        // Colunas da tabela 
    data = [];                // Linhas da tabela
    bindings_toSave = [];     // Registros mapeados quando salvar

    loading = true;
   
    renderedCallback()
    {
        // Prevents re-reloading
        if(this.loading == true)
        {
            let service = this.template.querySelector('c-call-service');
            service.callServiceMethod('retrieve', '', (call) => { if(call.status == 'CompletedSuccess') this.handleCallToRetrieve(call.response); });
        }
    }

    handleCallToRetrieve(response)
    {
        if(response.length > 0) { this.dataMap = new Map(response.map((binding) => [binding.qualifiedName, this.constructNonEditedBinding(binding)])); }  
        this.handleSearch('');
    }

    handleCallToSave() 
    { 
        try
        {
            this.saveUpdates(); 

            this.loading = true;
            this.bindings_toSave = [];
            this.dataMap.forEach((value, key, map) => this.filterBy(value, key, map, '', this.bindings_toSave, ''));
            this.callToSave();
        } catch (e) { console.log(e.message); }
    }

    handleAdd() 
    { 
        try 
        { 
            this.saveUpdates();
            let new_binding = this.constructNonEditedBinding({masterLabel:'',nomeClasse :'',estatico:false, qualifiedName:`${this.dataMap.size+1}`});

            this.loading = true;
            this.data = [];
            this.dataMap.set(new_binding.qualifiedName, new_binding);
            this.dataMap.forEach((value, key, map) => this.filterBy(value, key, map, '', this.data, 'added'));
            this.loading = false;
        }catch(e) { console.log(e.message); }
    }

    handleSearch(param) 
    {
        try
        {
            this.saveUpdates();

            this.loading = true;
            this.data = [];
            this.dataMap.forEach((value, key, map) => this.filterBy(value, key, map, param, this.data, 'masterlabel'));
            this.loading = false;
        } catch (e) { console.log(e.message); }
    }

    keyPressSearch(event) { if(event.keyCode == 13) this.handleSearch(event.currentTarget.value) }

    // Re-preenche um array com os valores no mapa de acordo com um filtro especificado || os modificados ficam sempre em primeiro
    filterBy(value, key, map, param, callbackArray, filter) 
    { 
        if(value.edited) callbackArray.unshift(map.get(key));
        else
        {
            switch (filter)
            {
                case 'masterlabel' :
                    if(value.masterLabel.startsWith(param)) callbackArray.push(map.get(key));
                    break;
    
                case 'added' :
                    callbackArray.unshift(map.get(key));
                    break;
            }  
        }
    }

    // Salva mudanças no mapa
    saveUpdates()
    {
        let datatable = this.template.querySelector('lightning-datatable');    
        
        try
        {
            for(let i in datatable.draftValues)
            {       
                let draft = datatable.draftValues[i];
                
                let tempRecord = this.constructEditedBinding(draft, this.dataMap.get(draft.qualifiedName)); 

                this.dataMap.set(tempRecord.qualifiedName, tempRecord);
            }
        } catch(e) { console.log(e.message); }
    }

    // Coloca um resgistro atualizado no lugar de um antigo no mapa
    constructEditedBinding(draftBind, old)
    {
        let temp = old;
        temp.masterLabel = draftBind.masterLabel ? draftBind.masterLabel : temp.masterLabel;
        temp.estatico = draftBind.estatico !== undefined ?  draftBind.estatico : temp.estatico;
        temp.nomeClasse = draftBind.nomeClasse ? draftBind.nomeClasse : temp.nomeClasse;
        temp.edited = true;

        return temp;
    }

    // Coloca bindings como Objetos no mapa 
    constructNonEditedBinding(draftBind)
    {
        let temp = new Object();
        temp.recordId = draftBind.recordId ? draftBind.recordId : undefined;
        temp.keyBinding = draftBind.keyBinding ? draftBind.keyBinding : undefined;
        temp.qualifiedName = draftBind.qualifiedName;
        temp.masterLabel = draftBind.masterLabel;
        temp.nomeClasse = draftBind.nomeClasse;
        temp.estatico = draftBind.estatico;
        
        return temp;
    }

    // Salva os bindings
    callToSave()
    {
        if(this.loading == true) // Allows re-rendering after save
        {
            let service = this.template.querySelector('c-call-service');
            service.setParams({ 'bindings' : JSON.stringify(this.bindings_toSave) });
            service.callServiceMethod('save', '', (call) => { if(call.status == 'CompletedSuccess') console.log('true'); });
        }
    }
}