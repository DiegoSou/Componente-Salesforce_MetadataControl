@isTest
public class C3C_MDT_ControlTest 
{
    // Método Auxiliar - buildMapperInstance
    public static C3C_MDT_ControlMapper buildMapperInstance()
    { return (C3C_MDT_ControlMapper) new C3C_MDT_ControlMapper().newInstance(Schema.getGlobalDescribe().get('C3C_MDT_control__mdt').newSObject()); }

    @isTest
    static void coverage()
    {
        // GIVEN
        Map<String, Object> paramsGetAllMetadata = new Map<String, Object>{ 'mdtlabel' => 'C3C_MDT_control' };
        Map<String, Object> paramsGetAllFields = new Map<String, Object>{ 'mdtlabel' => 'C3C_MDT_control' };
        Map<String, Object> paramsSave = new Map<String, Object>{ 'mdtlabel' => 'C3C_MDT_control', 'listjson' => '["{\\"DeveloperName\\":\\"TestMdt\\",\\"MasterLabel\\":\\"TestMdt\\",\\"QualifiedApiName\\":\\"TestMdt\\"}"]' };

        // WHEN
        C3C_MDT_ControlAdapter.callServiceMethod('getMetadatas', paramsGetAllMetadata);
        C3C_MDT_ControlAdapter.callServiceMethod('getColumns', paramsGetAllFields);
        C3C_MDT_ControlAdapter.callServiceMethod('saveMetadatas', paramsSave);

        buildMapperInstance().getObjectName();

        // THEN
    }
}