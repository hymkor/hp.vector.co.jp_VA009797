function mirror($src,$dst){
    Get-ChildItem -Path $src | ForEach-Object {
        $name = $_.Name
        if ( $name -eq "." -or $name -eq ".." ){
            continue
        }
        $newname = (Join-Path -Path $dst -ChildPath $name)
        Write-Host ("{0}`n-> {1}" -f $_.FullName,$newname)
        if ( $_.PSIsContainer ){
            if ( -not (Test-Path $newname) ){
                New-Item -Path $newname -ItemType "Directory"
            }
            mirror ($_.FullName) $newname
        } else {
            if ($name -match '\.html?$') {
                nkf32 -J -w8 $_.FullName > $newname
            } else {
                Copy-Item $_.FullName $newname -Force
            }
        }
    } | Out-Null
}

$root = Get-Location
$src = (Join-Path -Path $root -ChildPath "www")
$dst = (Join-Path -Path $root -ChildPath "docs")
mirror $src $dst
