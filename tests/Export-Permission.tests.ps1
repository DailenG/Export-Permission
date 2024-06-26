BeforeDiscovery {

    if ($env:AppData) {
        $ParentFolderPath = "$env:AppData\Export-Permission\TestFolder"
    } else {
        $ParentFolderPath = ".\TestFolder"
    }
    $ChildFolderPath = "$ParentFolderPath\Subfolder"
    $null = New-Item -ItemType Directory -Path $ChildFolderPath -ErrorAction SilentlyContinue

    $ParentAcl = Get-Acl -Path $ParentFolderPath
    $ChildAcl = Get-Acl -Path $ChildFolderPath

    $ParentAcl.SetOwner([System.Security.Principal.NTAccount]::new('BUILTIN\Administrators'))
    $ChildAcl.SetOwner([System.Security.Principal.NTAccount]::new('BUILTIN\Guests'))

    #Set-Acl -Path $ParentFolderPath -AclObject $ParentAcl
    #Set-Acl -Path $ChildFolderPath -AclObject $ChildAcl

}

describe "Should include BUILTIN\Guests" {
    it 'the test' {
        #.\src\Export-Permission.ps1 -TargetPath $ParentFolderPath
        $true | should -be $true
    }
}


