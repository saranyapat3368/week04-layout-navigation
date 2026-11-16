# Run from the folder containing INSTALL_WINDOWS.ps1
# Creates native Flutter runner files (web/android/ios/windows...) if absent.
$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
  Write-Error 'Flutter was not found. Install Flutter SDK and add it to PATH first.'
}
flutter create --project-name travel_app .
if ($LASTEXITCODE -ne 0) { throw 'flutter create failed' }
flutter pub get
if ($LASTEXITCODE -ne 0) { throw 'flutter pub get failed' }
Write-Host 'Setup completed! Run: flutter run -d chrome' -ForegroundColor Green
