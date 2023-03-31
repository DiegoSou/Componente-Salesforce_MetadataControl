public class C3C_Lib_Database implements C3C_Lib_IDatabase
{   
    public List<C3C_SObject> queryExecute(String query)
    {
        List<SObject> listResult = (List<SObject>) Database.query(query);
        
        return (List<C3C_SObject>) this.decoupleFromQuery(listResult);
    }

    public List<C3C_SObject> queryExecute(fflib_QueryFactory query)
    {
        List<C3C_SObject> listResult = (List<C3C_SObject>) this.queryExecute(query.toSOQL());
        // if(listResult.size() > 0 && !C3C_APP_ApplicationContext.contract.mapPagination.containsKey(query.pageNumber+1))
        // {
        // 	C3C_APP_ApplicationContext.addNewReferencePagination(listResult[listResult.size()-1].getByField(query.pageReferenceField));
        // }
        
        return (List<C3C_SObject>) listResult;
    }

    private List<C3C_SObject> decoupleFromQuery(List<SObject> listObjects)
    {
        List<C3C_SObject> listResult = new List<C3C_SObject>();
        for(SObject sObj : listObjects)
            listResult.add(new C3C_SObject(sObj));
        
        return (List<C3C_SObject>) listResult;
    }
}