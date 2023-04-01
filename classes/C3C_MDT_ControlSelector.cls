public class C3C_MDT_ControlSelector extends fflib_SObjectSelector implements C3C_MDT_IControlSelector
{
    // sObjectType do atual mdt
    public Schema.SObjectType getSObjectType() { return generic.getMdtSObjectType(); }

    // Campos __c do mdt + os defaults da domain
    public List<Schema.SObjectField> getSObjectFieldList() { return generic.getMdtFieldMap().values(); } 

    // Pega todos os registros do atual mdt
    public List<SObject> getAllMDTs()
    {
        fflib_QueryFactory query = newQueryFactory();
        List<SObject> sobjectsMdt = new List<SObject>();

        for(C3C_SObject obj : (List<C3C_SObject>) this.libDatabase.queryExecute(query.toSOQL())) 
        { 
            sobjectsMdt.add(obj.getRecordSObject()); 
        }
        
        return sobjectsMdt;
    }

    // mdt genérico
    public C3C_MDT_ControlDomain generic {get; private set;}
    public C3C_MDT_ControlDomain getGeneric() { if(generic == null) setGeneric('C3C_MDT_control'); return generic; }

    // utilize esse método para indicar qual será o metadado utilizado, através do seu dev name;
    public C3C_MDT_IControlSelector setGeneric(String devName) { this.generic = ((C3C_MDT_ControlDomain) C3C_DIContainer_Injector.newInstance('C3C_MDT_ControlDomain')).setDeveloperName(devName); return (C3C_MDT_IControlSelector) this; }
}