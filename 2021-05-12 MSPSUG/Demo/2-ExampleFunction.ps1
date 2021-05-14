function Get-Memory {
    $result = (Get-Ciminstance win32_computersystem).TotalPhysicalMemory

    [PSCustomObject]@{
        MemGB = $result/1MB -as [int]
    }
}