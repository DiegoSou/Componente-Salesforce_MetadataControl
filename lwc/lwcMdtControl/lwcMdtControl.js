import { LightningElement, api } from 'lwc';

// serve para preencher duas variáveis: o metadado selecionado, e as colunas (representando campos) deste metadado
export default class MdtControl extends LightningElement 
{
    mdt_selected; // Metadado selecionado
    mdt_columns;  // Colunas do metadado selecionado      
    
    loading = true;

    // public function - retorna o metadado selecionado
    @api getSelected() { return this.mdt_selected; }

    // public function - retorna as colunas do metadado selecionado
    @api getColumns() { return this.mdt_columns; }

    renderedCallback()
    {
        // Prevents re-reloading
        if(this.loading)
        {
            let service = this.template.querySelector('c-call-service');
            service.setParams({ 'mdtlabel' : 'C3C_MDT_control' })
            service.callServiceMethod('getMetadatas', '', (call) => { if(call.status == 'CompletedSuccess') this.handleCallToGetMetadatas(call.response); });
        }
    }

    // Constrói a lista de rótulos dos metadados controláveis/configuráveis
    handleCallToGetMetadatas(response)
    {
        response = JSON.parse(response);
        if(response.length > 0) { this.generateHtmlSelect(response.map((v) => v.MasterLabel)); }
    }

    // Gera uma tag select com cada option representando um metadado disponível
    generateHtmlSelect(masterlabels)
    {
        let htmlvalue = '';
        let container = this.template.querySelector('div[data-id="select-container"]');
        
        htmlvalue = '<div class="slds-select_container"><select class="slds-select" id="select-01" required="">';
        masterlabels.forEach((label) => {htmlvalue += '<option value="'+label+'">'+label+'</option>'});
        htmlvalue += '</select></div>';

        container.innerHTML = htmlvalue;
        this.loading = false;
    }

    generateColumns()
    {
        // Prevents unnecessary call
        if(this.mdt_selected)
        {
            let service = this.template.querySelector('c-call-service');
            service.setParams({ 'mdtlabel' : this.mdt_selected });

            service.callServiceMethod('getColumns', '', (call) => {
                if(call.status == 'CompletedSuccess') 
                {
                    this.mdt_columns = call.response  // seta columns ainda em formato json
                    
                    // termina toda funcionalidade do componente | manda evento
                    this.dispatchEvent(new CustomEvent('generatedcolumns'));  
                }
            });
        }
    }

    // Metadado selecionado
    handleSelected() 
    {  
        let selectTag = this.template.querySelector('select'); 
        this.mdt_selected = selectTag.options[selectTag.selectedIndex].value;  // seta o metadado selecionado
        
        this.generateColumns();  // call para gerar as colunas | pegar os campos do metadado selecionado 
    }
}