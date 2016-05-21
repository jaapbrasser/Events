configuration JeaDemo1
{
    Import-DscResource -ModuleName xjea

    xJeaToolKit DuPSUGDemo1
    {
        Name         = 'DuPSUGDemo1'
        CommandSpecs = @"
Name,Parameter,ValidateSet
Get-Process
Get-CimInstance,ClassName,CIM_OperatingSystem;Win32_Operatingsystem;CIM_Bios;Win32_Bios
"@
    }
    xJeaEndPoint DuPSUGDemo1
    {
        Name                   = 'DuPSUGDemo1'
        Toolkit                = 'DuPSUGDemo1'
        SecurityDescriptorSddl = 'O:NSG:BAD:P(A;;GX;;;WD)'
        DependsOn              = '[xJeaToolKit]DuPSUGDemo1'
    }
}

JeaDemo1 -OutputPath C:\DuPSUGDemo

Start-DscConfiguration -Path C:\DuPSUGDemo -ComputerName localhost -Verbose -Wait -Debug -Force