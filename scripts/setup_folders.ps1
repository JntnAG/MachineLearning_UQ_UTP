$folders = @(
    "MachineLearning_UQ_UTP",
    "MachineLearning_UQ_UTP\.github",
    "MachineLearning_UQ_UTP\01-machine-learning-fundamentos",
    "MachineLearning_UQ_UTP\02-deep-learning-computer-vision",
    "MachineLearning_UQ_UTP\03-modelos-probabilisticos",
    "MachineLearning_UQ_UTP\04-graph-neural-networks",
    "MachineLearning_UQ_UTP\05-nlp-transformers",
    "MachineLearning_UQ_UTP\06-clustering-manifold-learning",
    "MachineLearning_UQ_UTP\07-mlops-despliegue",
    "MachineLearning_UQ_UTP\08-bases-de-datos-sql-nosql",
    "MachineLearning_UQ_UTP\09-web-scraping-datos",
    "MachineLearning_UQ_UTP\10-topicos-avanzados-y-etica"
)

foreach ($f in $folders) {
    if (-not (Test-Path $f)) {
        New-Item -ItemType Directory -Path $f | Out-Null
    }
}
Write-Host "Folders created successfully."
