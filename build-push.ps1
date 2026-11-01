param(
    [string]$User = "shardox",
    [int[]]$Versions = 16..24,
    [switch]$NoPush
)

$ErrorActionPreference = "Stop"

foreach ($v in $Versions) {
    $os = if ($v -le 19) { "bullseye" } else { "bookworm" }
    docker build --build-arg NODE_VERSION=$v --build-arg DEBIAN=$os -t "$User/nodejs:$v" .
    if ($LASTEXITCODE -ne 0) { throw "build node $v gagal" }
    if (-not $NoPush) {
        docker push "$User/nodejs:$v"
        if ($LASTEXITCODE -ne 0) { throw "push node $v gagal" }
    }
}

if (-not $NoPush -and $Versions -contains 24) {
    docker tag "$User/nodejs:24" "$User/nodejs:latest"
    docker push "$User/nodejs:latest"
}
