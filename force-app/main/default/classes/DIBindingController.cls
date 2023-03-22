public class DIBindingController 
{
    public class DIBindingControllerException extends Exception {}

    private final Integer PAGE_SIZE = 10;

    // Mapa de Registros Carregados ->  (São os que serão inseridos, listados, ou que já existem)
    public Map<String, C3C_DI_biding__mdt> bindingByApiName {get; set;}  
    
    // Lista de registros na paginação 
    public List<C3C_DI_biding__mdt> bindings {get; set;}  

    // Lista de registros em criação
    public List<C3C_DI_biding__mdt> tempBindings {get; set;}
    
    // set controller
    public Apexpages.StandardSetController setCon {
        get {
            if(setCon == null)
            {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [SELECT Id, QualifiedApiName, MasterLabel, ClasseApex__c, Estatico__c FROM C3C_DI_biding__mdt]
                ));
            }
            return setCon;
        }
        set;
    }
    
    public DIBindingController()
    {
		bindings = new List<C3C_DI_biding__mdt>();
        tempBindings = new List<C3C_DI_biding__mdt>();
        bindingByApiName = new Map<String, C3C_DI_biding__mdt>();
        
        setCon.setPageSize(PAGE_SIZE);
        loadBindingItemData();
    }

    public void create() 
    { 
        tempBindings.add(new C3C_DI_biding__mdt(MasterLabel = '', ClasseApex__c = '', Estatico__c = false)); 

        loadBindingItemData(); 
    }
    
    // Reloads the page
    public void save()
    {
        Metadata.DeployContainer container = new Metadata.DeployContainer();

        List<String> bindingFullNames = new List<String>();
        
        // Retrieve Existing Bindings
        for(String recordName : bindingByApiName.keySet())
        {
            bindingFullNames.add('C3C_DI_biding.' + recordName);  // ["C3C_DI_biding.AccountDomain","C3C_DI_biding.AccountAdapter"]
        } 
        List<Metadata.Metadata> originalRecords = Metadata.Operations.retrieve(
            Metadata.MetadataType.CustomMetadata, bindingFullNames
        );

        // Add to container
        for(Metadata.Metadata originalRecord : originalRecords)
        {
            Metadata.CustomMetadata bidingRecord = (Metadata.CustomMetadata) originalRecord;

            String bidingRecordName = bidingRecord.fullName.substringAfter('.');
            
            C3C_DI_biding__mdt bidingToCopy = bindingByApiName.get(bidingRecordName);
            
            for(Metadata.CustomMetadataValue recValue : bidingRecord.values)
            {
                recValue.value = bidingToCopy.get(recValue.field);
            }
            
            container.addMetadata(bidingRecord);
        }

        for(C3C_DI_biding__mdt toCreate : tempBindings)
        {
            Metadata.CustomMetadata bindingRecord = new Metadata.CustomMetadata();
            bindingRecord.fullName = 'C3C_DI_biding.' + toCreate.MasterLabel;
            bindingRecord.label = toCreate.MasterLabel;
            bindingRecord.protected_x = false;

            bindingRecord.values.add(new Metadata.CustomMetadataValue());
            bindingRecord.values[0].field = 'Estatico__c';
            bindingRecord.values[0].value = toCreate.Estatico__c;

            bindingRecord.values.add(new Metadata.CustomMetadataValue());
            bindingRecord.values[1].field = 'ClasseApex__c';
            bindingRecord.values[1].value = toCreate.ClasseApex__c;

            container.addMetadata(bindingRecord);
        }
        
        Id asyncResultId = Metadata.Operations.enqueueDeployment(container, null);
        return;
    }

    public void loadBindingItemData()
    {
        bindings = new List<C3C_DI_biding__mdt>(tempBindings);

        for(SObject record : setCon.getRecords())
        {
            String qualifiedName = (String) record.get('QualifiedApiName');
            
            if(bindingByApiName.containsKey(qualifiedName))
            {
                bindings.add((C3C_DI_biding__mdt) bindingByApiName.get(qualifiedName));
            }
            else
            {
                // Adiciona na lista que exibe os metadados o metadado existente 
                // Adiciona no mapa de listados o novo metadado existente

                C3C_DI_biding__mdt newBiding = new C3C_DI_biding__mdt(
                    QualifiedApiName = (String) record.get('QualifiedApiName'),
                    MasterLabel = (String) record.get('MasterLabel'),
                    ClasseApex__c = (String) record.get('ClasseApex__c'),
                    Estatico__c = (Boolean) record.get('Estatico__c')
                );

                bindings.add(newBiding); 
                bindingByApiName.put(newBiding.QualifiedApiName, newBiding);
            }
        }

        System.debug('Bindings visualize list => ' + bindings);
        System.debug('Bindings loaded map => ' + bindingByApiName);
    }

    public void Previous() 
    {
        setCon.previous();
        loadBindingItemData();
    }

    public void Next() 
    {
        setCon.next();
        loadBindingItemData();
    }

    public Boolean getHasPrevious()
    {
        return setCon.getHasPrevious();
    }
    public Boolean getHasNext()
    {
        return setCon.getHasPrevious();
    }
}