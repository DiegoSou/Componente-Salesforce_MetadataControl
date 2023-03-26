@isTest
public class C3C_BindingControlAdapterTest
{
    public static void criarStub()
    {
        C3C_DIContainer_Injector.createInstance('C3C_BindingControlService', Test.createStub(C3C_BindingControlService.class, new C3C_BindingControlServiceStub()));
    }

    public static void setupContext(String bodyMapKey, String bodyMapValue) {
        criarStub();
        C3C_APP_ContractInterfaceApplication contract = (C3C_APP_ContractInterfaceApplication) C3C_DIContainer_Injector.newInstance(
            'C3C_APP_ContractInterfaceApplication', 
            JSON.serialize(new Map<String, Object>{
                'requestBody' => new Map<string,Object>{
                    'service' => 'service',
                    'serviceMethod' => 'serviceMethod',
                    'bodyMap' => new Map<String, String>{
                        bodyMapKey => bodyMapValue
                    }
                },
                'enabledPath' => false,
                'returnType' => 'returnType'
        }));
        C3C_APP_ApplicationContext.initialize(contract);
    }

    @isTest
    static void getMapServiceMethodToClassMethodTest()
    {
        Map<String,String> mapaADPPorNomeMetodo = new Map<String,String>();
        C3C_BindingControlAdapter adapter = new C3C_BindingControlAdapter();
        mapaADPPorNomeMetodo.putAll(adapter.getMapServiceMethodToClassMethod());
    }

    @isTest
    static void ADPretrieve()
    {
        C3C_BindingControlAdapter.ADP_Save adp = new C3C_BindingControlAdapter.ADP_Save();
        setupContext('retrieve', '');

        adp.callMethod();
    }

    @isTest
    static void ADPsave()
    {
        C3C_BindingControlAdapter.ADP_Save adp = new C3C_BindingControlAdapter.ADP_Save();
        setupContext('save', '');

        adp.callMethod();
    }

    // Stubs
    public class C3C_BindingControlServiceStub implements System.StubProvider
    {
        public Object handleMethodCall(
            Object stubbedObject, 
            String stubbedMethodName,
            Type returnType, 
            List<System.Type> 
            listOfParamTypes, 
            List<String> listOfParamNames,
            List<Object> listOfArgs
        )
        {
            Object returnValue;
            
            return returnValue;
        }
    }

    public class C3C_DIContainer_BindingServiceStub implements System.StubProvider
    {
        public Object handleMethodCall(
            Object stubbedObject, 
            String stubbedMethodName,
            Type returnType, 
            List<System.Type> 
            listOfParamTypes, 
            List<String> listOfParamNames,
            List<Object> listOfArgs
        )
        {
            Object returnValue;
            
            return returnValue;
        }
    }
}