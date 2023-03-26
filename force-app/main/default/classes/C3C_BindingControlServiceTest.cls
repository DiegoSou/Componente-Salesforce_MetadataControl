@isTest
public with sharing class C3C_BindingControlServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector() {}

    @isTest
    static void saveTest()
    {
        setupInjector();

        Test.startTest();
        new C3C_BindingControlService().save('[{"qualifiedName":"92","masterLabel":"TesteBinding","nomeClasse":"TesteBinding","estatico":true,"edited":true}]');
        Test.stopTest();

        System.assertEquals(1, [SELECT Id FROM C3C_DI_binding__mdt WHERE ClasseApex__c = 'TesteBinding'].size());
    }
}
