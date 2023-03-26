public class C3C_BindingControlService implements C3C_IBindingControlService {

    private final String NAMESPACE = 'C3C_DI_binding.';
    
    public class C3C_BindingsControlServiceException extends Exception {}

    public Boolean save(String bindingsJson) 
    {
        try
        {
            Metadata.DeployContainer container = new Metadata.DeployContainer(); // new
            List<C3C_DIContainer_BindingDomain> bindings = (List<C3C_DIContainer_BindingDomain>) JSON.deserialize(bindingsJson, List<C3C_DIContainer_BindingDomain>.class);
            
            if(bindings.isEmpty()) { System.debug('Nenhuma alteração nos bindings'); }
            for(C3C_DIContainer_BindingDomain bind : bindings)
            {
                Metadata.CustomMetadata custom_mdt = new Metadata.CustomMetadata(); // new
                custom_mdt.fullName = bind.recordId == null ? NAMESPACE + bind.masterLabel : NAMESPACE + bind.qualifiedName;  // novo registro x existente
                custom_mdt.label = bind.masterLabel;
                custom_mdt.protected_x = false;
    
                custom_mdt.values.add(new Metadata.CustomMetadataValue()); // new
                custom_mdt.values[0].field = 'Estatico__c';
                custom_mdt.values[0].value = bind.estatico;
    
                custom_mdt.values.add(new Metadata.CustomMetadataValue()); // new
                custom_mdt.values[1].field = 'ClasseApex__c';
                custom_mdt.values[1].value = bind.nomeClasse;
    
                container.addMetadata(custom_mdt);
            }
    
            Id asyncResultId = Metadata.Operations.enqueueDeployment(container, null);
            return true;

        } catch (Exception e) { System.debug(e.getMessage() + ' Line ' + e.getLineNumber()); return false; }
    }
}