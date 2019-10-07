Add-Type -AssemblyName "System.Drawing"
$location = "~\Pictures\Spotlight Wallpapers"
$spotlightImages = "$env:LOCALAPPDATA\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
New-Item $location -Type Directory -ErrorAction SilentlyContinue

# grab spotlight images that have the right size and aspect ratio, then copy + rename them
Get-ChildItem $spotlightImages |
    Where-Object Length -gt 300000 | 
    Foreach-Object {
        $image = [System.Drawing.Image]::FromFile($_.FullName);
        $ratio = $image.Width / $image.Height
        $image.Dispose()
        if ($ratio -gt 1) {
            Copy-Item $_.FullName -Destination "$location\$($_.Name).jpg"
        }
    }