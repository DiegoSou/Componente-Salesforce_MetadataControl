public virtual without sharing class C3C_MDT_ControlAdapter extends C3C_APP_ServiceApplicationAdapter
{
    public override Map<String,String> getMapServiceMethodToClassMethod() 
    {
        return new Map<String, String> {
            'getMetadatas' => 'C3C_MDT_ControlAdapter.ADP_Metadatas',
            'getColumns' => 'C3C_MDT_ControlAdapter.ADP_Columns',
            'saveMetadatas' => 'C3C_MDT_ControlAdapter.ADP_Save'
        };
    }

    public class ADP_Metadatas extends ClassMethod
    {
        public override void callMethod()
        {
            Map<String, String> mapParams = C3C_APP_ApplicationContext.getBody();

            C3C_APP_ApplicationContext.setResponse(instanceC3C_MDT_IControlService.metadatas(mapParams.get('mdtlabel')));
        }
    }

    public class ADP_Columns extends ClassMethod
    {
        public override void callMethod()
        {
            Map<String, String> mapParams = C3C_APP_ApplicationContext.getBody();

            C3C_APP_ApplicationContext.setResponse(instanceC3C_MDT_IControlService.columns(mapParams.get('mdtlabel')));
        }
    }

    public class ADP_Save extends ClassMethod
    {
        public override void callMethod()
        {
            Map<String, String> mapParams = C3C_APP_ApplicationContext.getBody();

            instanceC3C_MDT_IControlService.save(mapParams.get('mdtlabel'), mapParams.get('listjson'));
        }
    }

    // Instancias
    private static C3C_MDT_IControlService instanceC3C_MDT_IControlService
    {
        get 
        {
            if(instanceC3C_MDT_IControlService == null)
                instanceC3C_MDT_IControlService = (C3C_MDT_IControlService) C3C_DIContainer_Injector.getInstance('C3C_MDT_ControlService');

            return instanceC3C_MDT_IControlService;
        }
        set;
    }
}