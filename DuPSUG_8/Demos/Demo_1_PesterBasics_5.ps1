break

psedit .\Demo_1_PesterBasics_5.tests.ps1

Invoke-Pester -Script .\Demo_1_PesterBasics_5.tests.ps1

Invoke-Pester -Script .\Demo_1_PesterBasics_5.tests.ps1 -OutputFile .\PesterResults.xml -OutputFormat NUnitXml

$XMLResults = [xml](Get-Content -Path .\PesterResults.xml)

# View the results
$XMLResults.'test-results'

# View individual test results
$XMLResults.'test-results'.'test-suite'.results.'test-suite'.results.'test-case'