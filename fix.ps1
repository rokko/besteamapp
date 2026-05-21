$file = 'lib\playpage\choose_pitch.dart'
$content = [System.IO.File]::ReadAllText($file)

# Correzione 1: Rimuovi "fontStyle: FontStyle.italic,"
$content = $content -replace 'fontSize: 20, fontStyle: FontStyle\.italic,', 'fontSize: 20,'

# Correzione 2: Cambia dimensioni immagine
$content = $content -replace 'width: 86, height: 56', 'width: 107, height: 60'

# Correzione 3: Cambia fontSize e colore
$content = $content -replace 'fontSize: 12, color: Colors\.white70', 'fontSize: 14, color: Color.fromRGBO\(209, 209, 209, 1\)'

[System.IO.File]::WriteAllText($file, $content)
Write-Host "Correzioni applicate"
