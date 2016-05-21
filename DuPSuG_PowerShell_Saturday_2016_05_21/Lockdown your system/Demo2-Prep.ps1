configuration JeaDemo2
{
    Import-DscResource -module xjea

    xJeaToolKit DuPSUGDemo2
    {
        Name         = 'DuPSUGDemo2'
        CommandSpecs = @'
Module
Hyper-V
'@
    }
    xJeaEndPoint DuPSUGDemo2
    {
        Name                   = 'DuPSUGDemo2'
        Toolkit                = 'DuPSUGDemo2'
        SecurityDescriptorSddl = 'O:NSG:BAD:P(A;;GA;;;S-1-5-21-3817790416-2066694576-4058203337-1002)S:P(AU;FA;GA;;;WD)(AU;SA;GXGW;;;WD)'
        DependsOn              = '[xJeaToolKit]DuPSUGDemo2'
    }
}

JeaDemo2 -OutputPath C:\DuPSUGDemo

Start-DscConfiguration -Path C:\DuPSUGDemo -ComputerName localhost -Verbose -Wait -Debug -Force

Set-PSSessionConfiguration -Name DuPSUGDemo2 -SecurityDescriptorSddl 'O:NSG:BAD:P(A;;GA;;;S-1-5-21-3817790416-2066694576-4058203337-1002)S:P(AU;FA;GA;;;WD)(AU;SA;GXGW;;;WD)'