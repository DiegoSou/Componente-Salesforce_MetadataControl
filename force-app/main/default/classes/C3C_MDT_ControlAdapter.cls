public virtual without sharing class C3C_MDT_ControlAdapter
{
    private static Map<String,String> serviceMethodToClassMethod = new Map<String, String> 
    {
        'getMetadatas' => 'C3C_MDT_ControlAdapter.ADP_Metadatas',
        'getColumns' => 'C3C_MDT_ControlAdapter.ADP_Columns',
        'saveMetadatas' => 'C3C_MDT_ControlAdapter.ADP_Save'
    };

    public class ADP_Metadatas extends ClassMethod
    {
        public override ClassMethod callMethod(Map<String, Object> methodParams)
        {
            this.methodResponse = instanceC3C_MDT_IControlService.metadatas((String) methodParams.get('mdtlabel'));
            return this;
        }
    }

    public class ADP_Columns extends ClassMethod
    {
        public override ClassMethod callMethod(Map<String, Object> methodParams)
        {
            this.methodResponse = instanceC3C_MDT_IControlService.columns((String) methodParams.get('mdtlabel'));
            return this;
        }
    }

    public class ADP_Save extends ClassMethod
    {
        public override ClassMethod callMethod(Map<String, Object> methodParams)
        {
            instanceC3C_MDT_IControlService.save((String) methodParams.get('mdtlabel'), (String) methodParams.get('listjson'));
            return this;
        }
    }

    // Instancias
    private static C3C_MDT_IControlService instanceC3C_MDT_IControlService
    {
        get 
        {
            if(instanceC3C_MDT_IControlService == null) 
            {
                instanceC3C_MDT_IControlService = (C3C_MDT_IControlService) Type.forName('C3C_MDT_ControlService').newInstance(); 
            }

            return instanceC3C_MDT_IControlService;
        }
        set;
    }

    // Call service
    @AuraEnabled
    public static String callServiceMethod(String methodName, Map<String, Object> methodParams) 
    {
        if(!serviceMethodToClassMethod.containsKey(methodName)) { throw new C3C_MDT_ControlAdapterException('Método não definido - ' + methodName); }

        return (
            (ClassMethod) Type.forName(serviceMethodToClassMethod.get(methodName))
            .newInstance()
        )
        .callMethod(methodParams)
        .methodResponse;
    }

    // Class method
    public class C3C_MDT_ControlAdapterException extends Exception {}
    public abstract class ClassMethod 
    { 
        public String methodResponse { get{ return methodResponse == null ? '' : methodResponse; } protected set; }
        public abstract ClassMethod callMethod(Map<String, Object> methodParams); 
    }
}