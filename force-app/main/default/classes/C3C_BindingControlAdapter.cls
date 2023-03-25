public virtual without sharing class C3C_BindingControlAdapter extends C3C_APP_ServiceApplicationAdapter
{
    public override Map<String,String> getMapServiceMethodToClassMethod() 
    {
        return new Map<String, String> {
            'retrieve' => 'C3C_BindingControlAdapter.ADP_Retrieve',
            'save' => 'C3C_BindingControlAdapter.ADP_Save'
        };
    }

    public class ADP_Retrieve extends ClassMethod
    {
        public override void callMethod() 
        {
            Map<String, String> mapParams = C3C_APP_ApplicationContext.getBody();

            C3C_APP_ApplicationContext.setResponse(instanceC3C_DIContainer_IBindingService.getAllBindings());
        }
    }

    public class ADP_Save extends ClassMethod
    {
        public override void callMethod()
        {
            Map<String, String> mapParams = C3C_APP_ApplicationContext.getBody();

            C3C_APP_ApplicationContext.setResponse(instanceC3C_IBindingControl.save(mapParams.get('bindings')));
        }
    }

   //Instancia
   private static C3C_DIContainer_IBindingService instanceC3C_DIContainer_IBindingService
   {
       get
       {
            if(instanceC3C_DIContainer_IBindingService == null)
                instanceC3C_DIContainer_IBindingService = (C3C_DIContainer_IBindingService) C3C_DIContainer_Injector.getInstance('C3C_DIContainer_BindingService');

           return instanceC3C_DIContainer_IBindingService;
       }
       set;
   }

   private static C3C_IBindingControlService instanceC3C_IBindingControl
   {
       get
       {
            if(instanceC3C_IBindingControl == null)
                instanceC3C_IBindingControl = (C3C_IBindingControlService) Type.forName('C3C_BindingControlService').newInstance();

            return instanceC3C_IBindingControl;
       }
       set;
   }
}