$port = 8000
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Prefixes.Add("http://127.0.0.1:$port/")

try {
    $listener.Start()
    Write-Host "ResumeRank web server successfully started at http://localhost:$port/"
} catch {
    Write-Error "Failed to start listener: $_"
    exit 1
}

$rootFolder = $PSScriptRoot

while ($listener.IsListening) {
    try {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        $rawPath = [System.Uri]::UnescapeDataString($request.Url.LocalPath)
        
        # Clean route mappings
        if ($rawPath -eq "/" -or $rawPath -eq "/home" -or $rawPath -eq "/index.html") {
            $rawPath = "/index.html"
        } elseif ($rawPath -eq "/screening" -or $rawPath -eq "/screening/" -or $rawPath -eq "/dashboard" -or $rawPath -eq "/dashboard/" -or $rawPath -eq "/results" -or $rawPath -eq "/results/") {
            $rawPath = "/screening.html"
        } elseif ($rawPath -eq "/signin" -or $rawPath -eq "/signin/") {
            $rawPath = "/signin.html"
        } elseif ($rawPath -eq "/signup" -or $rawPath -eq "/signup/") {
            $rawPath = "/signup.html"
        }
        
        # Prevent directory traversal
        $relativePath = $rawPath.TrimStart('/').Replace('/', [System.IO.Path]::DirectorySeparatorChar)
        $fullPath = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($rootFolder, $relativePath))
        
        if (-not $fullPath.StartsWith($rootFolder, [System.StringComparison]::OrdinalIgnoreCase)) {
            $response.StatusCode = 403
            $response.Close()
            continue
        }
        
        if (Test-Path $fullPath -PathType Leaf) {
            $bytes = [System.IO.File]::ReadAllBytes($fullPath)
            $ext = [System.IO.Path]::GetExtension($fullPath).ToLower()
            
            switch ($ext) {
                ".html" { $response.ContentType = "text/html; charset=utf-8" }
                ".css"  { $response.ContentType = "text/css; charset=utf-8" }
                ".js"   { $response.ContentType = "text/javascript; charset=utf-8" }
                ".json" { $response.ContentType = "application/json; charset=utf-8" }
                ".txt"  { $response.ContentType = "text/plain; charset=utf-8" }
                ".png"  { $response.ContentType = "image/png" }
                ".jpg"  { $response.ContentType = "image/jpeg" }
                ".svg"  { $response.ContentType = "image/svg+xml" }
                default { $response.ContentType = "application/octet-stream" }
            }
            
            $response.ContentLength64 = $bytes.Length
            $response.OutputStream.Write($bytes, 0, $bytes.Length)
        } else {
            $response.StatusCode = 404
            $buffer = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
            $response.ContentLength64 = $buffer.Length
            $response.OutputStream.Write($buffer, 0, $buffer.Length)
        }
        $response.Close()
    } catch {
        # Catch any request loop errors cleanly
    }
}
