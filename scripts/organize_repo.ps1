# Script para reorganizar los archivos del repositorio MachineLearning_UQ_UTP

$rootDir = $PSScriptRoot

# Crear carpetas si no existen
$folders = @(
    "01-machine-learning-fundamentos\slides",
    "01-machine-learning-fundamentos\notebooks",
    "02-deep-learning-computer-vision\slides",
    "02-deep-learning-computer-vision\notebooks",
    "03-modelos-probabilisticos\slides",
    "03-modelos-probabilisticos\notebooks",
    "04-graph-neural-networks\slides",
    "04-graph-neural-networks\notebooks",
    "05-nlp-transformers\slides",
    "05-nlp-transformers\notebooks",
    "06-clustering-manifold-learning\slides",
    "06-clustering-manifold-learning\notebooks",
    "07-mlops-despliegue\slides",
    "07-mlops-despliegue\notebooks",
    "08-bases-de-datos-sql-nosql\slides",
    "08-bases-de-datos-sql-nosql\data",
    "09-web-scraping-datos\slides",
    "09-web-scraping-datos\notebooks",
    "10-topicos-avanzados-y-etica\slides",
    "docs",
    ".github"
)

foreach ($f in $folders) {
    $path = Join-Path $rootDir $f
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path | Out-Null
    }
}

$sourceBase = Join-Path $rootDir "marchine learning curso UQ\slides de clase"
if (-not (Test-Path $sourceBase)) {
    Write-Host "La carpeta fuente '$sourceBase' no existe. Asegúrate de ejecutar este script en la raíz del repositorio." -ForegroundColor Red
    exit
}

# Diccionario de movimientos: clave=archivo/patrón en la ruta origen, valor=carpeta destino
$moves = @{
    # 01 Fundamentos y Clásico
    "00 RepasoAlgebraLineal.pdf" = "01-machine-learning-fundamentos\slides"
    "00 Python_basics.ipynb" = "01-machine-learning-fundamentos\notebooks"
    "00Google_Colab_Tutorial.ipynb" = "01-machine-learning-fundamentos\notebooks"
    "01 Introducci*n al Aprendizaje de Maquina.pdf" = "01-machine-learning-fundamentos\slides"
    "01BasicsML.ipynb" = "01-machine-learning-fundamentos\notebooks"
    "02 Repaso Prob&Est.pdf" = "01-machine-learning-fundamentos\slides"
    "02.ipynb" = "01-machine-learning-fundamentos\notebooks"
    "03LinearRegresionI.pdf" = "01-machine-learning-fundamentos\slides"
    "03LinearRegresionI.ipynb" = "01-machine-learning-fundamentos\notebooks"
    "04RegresionII.pdf" = "01-machine-learning-fundamentos\slides"
    "04RegresionII.ipynb" = "01-machine-learning-fundamentos\notebooks"
    "05Proyectos_regresion.ipynb" = "01-machine-learning-fundamentos\notebooks"
    "06 Clasificaci*n I.pdf" = "01-machine-learning-fundamentos\slides"
    "06Clasificacion_cuadratica_lineal.ipynb" = "01-machine-learning-fundamentos\notebooks"
    "07 Clasificaci*n II.pdf" = "01-machine-learning-fundamentos\slides"
    "07ModeloRegresionLogistica.ipynb" = "01-machine-learning-fundamentos\notebooks"
    "14ArbolesDeDecision.pdf" = "01-machine-learning-fundamentos\slides"
    "14ArbolesDeDecision.ipynb" = "01-machine-learning-fundamentos\notebooks"
    "15BosqueAleatorio.pdf" = "01-machine-learning-fundamentos\slides"
    "15RandomForest.ipynb" = "01-machine-learning-fundamentos\notebooks"
    "16KNearestNeighbours.pdf" = "01-machine-learning-fundamentos\slides"
    "16kNN.ipynb" = "01-machine-learning-fundamentos\notebooks"
    "22SVM.pdf" = "01-machine-learning-fundamentos\slides"
    "22SVM.ipynb" = "01-machine-learning-fundamentos\notebooks"

    # 02 Deep Learning
    "08RedesNeuronales.pdf" = "02-deep-learning-computer-vision\slides"
    "08Neural_Networks.ipynb" = "02-deep-learning-computer-vision\notebooks"
    "09RedesNeuronales_i.ipynb" = "02-deep-learning-computer-vision\notebooks"
    "10RedesNeuronalesII Keras.pdf" = "02-deep-learning-computer-vision\slides"
    "11RedesNeuronalesIII.pdf" = "02-deep-learning-computer-vision\slides"
    "12_Image_classification_CATDOG_1overfit.ipynb" = "02-deep-learning-computer-vision\notebooks"
    "13_Image_classification_CATDOG_2Cool.ipynb" = "02-deep-learning-computer-vision\notebooks"
    "26Autoencoders.pdf" = "02-deep-learning-computer-vision\slides"
    "26Autoencoders.ipynb" = "02-deep-learning-computer-vision\notebooks"
    "27GANs.pdf" = "02-deep-learning-computer-vision\slides"
    "27_1_GANS_1.ipynb" = "02-deep-learning-computer-vision\notebooks"
    "27_1_DCGANS_2.ipynb" = "02-deep-learning-computer-vision\notebooks"
    "33ObjectDetection.pdf" = "02-deep-learning-computer-vision\slides"
    "33R_CNN.ipynb" = "02-deep-learning-computer-vision\notebooks"
    "33_YOLOv8.ipynb" = "02-deep-learning-computer-vision\notebooks"
    "CapturaDeImagenes.ipynb" = "02-deep-learning-computer-vision\notebooks"

    # 03 Probabilisticos (desde "2B Probabilistic Models")
    "2B Probabilistic Models\*.pptx" = "03-modelos-probabilisticos\slides"
    "2B Probabilistic Models\*.ipynb" = "03-modelos-probabilisticos\notebooks"
    "2B Probabilistic Models\0B normalizing flows\*.pptx" = "03-modelos-probabilisticos\slides"
    "2B Probabilistic Models\0B normalizing flows\*.ipynb" = "03-modelos-probabilisticos\notebooks"

    # 04 GNN (desde "31Graph")
    "31Graph\*.pptx" = "04-graph-neural-networks\slides"
    "31Graph\*.ipynb" = "04-graph-neural-networks\notebooks"

    # 05 NLP Transformers
    "17ProcesamientodeLenguajeNatural.pdf" = "05-nlp-transformers\slides"
    "17_Basics_PLN_Bow_TF_embed.ipynb" = "05-nlp-transformers\notebooks"
    "17_2_18_PLN_CNN.ipynb" = "05-nlp-transformers\notebooks"
    "19RNN_LSTM.pdf" = "05-nlp-transformers\slides"
    "19RNN.ipynb" = "05-nlp-transformers\notebooks"
    "28_1_Introduccion*.pdf" = "05-nlp-transformers\slides"
    "28_2_Atencion*.pdf" = "05-nlp-transformers\slides"
    "28_transformer.ipynb" = "05-nlp-transformers\notebooks"

    # 06 Clustering
    "20ClusterJerarquicoDendogramas.pdf" = "06-clustering-manifold-learning\slides"
    "20Clustering_Jer*rquico.ipynb" = "06-clustering-manifold-learning\notebooks"
    "20ClusterDBSCAN.pdf" = "06-clustering-manifold-learning\slides"
    "20_Cluster_DBScan.ipynb" = "06-clustering-manifold-learning\notebooks"
    "21Cluster_Kmeans.pdf" = "06-clustering-manifold-learning\slides"
    "21ClusteringK_means.ipynb" = "06-clustering-manifold-learning\notebooks"
    "23Cluster_GMM.pdf" = "06-clustering-manifold-learning\slides"
    "23GaussianMixturesModels.ipynb" = "06-clustering-manifold-learning\notebooks"
    "24PCA.pdf" = "06-clustering-manifold-learning\slides"
    "24PCA.ipynb" = "06-clustering-manifold-learning\notebooks"
    "24_2_25_OtrosclusteringApproaches.ipynb" = "06-clustering-manifold-learning\notebooks"
    "34ManifoldLearning.pdf" = "06-clustering-manifold-learning\slides"
    "34Manifold_Learning.ipynb" = "06-clustering-manifold-learning\notebooks"
    "34_2_Manifold_Learning_IsoMap.ipynb" = "06-clustering-manifold-learning\notebooks"
    "35tSNE_Umap.pdf" = "06-clustering-manifold-learning\slides"
    "35tSNE_UMAP.ipynb" = "06-clustering-manifold-learning\notebooks"

    # 07 MLOps
    "MLOPs\*.pdf" = "07-mlops-despliegue\slides"
    "MLOPs\*.ipynb" = "07-mlops-despliegue\notebooks"

    # 08 BD
    "43_database sql nosql\*.pdf" = "08-bases-de-datos-sql-nosql\slides"
    "43_database sql nosql\43_1_datos\*" = "08-bases-de-datos-sql-nosql\data"

    # 09 Web Scraping
    "42DataScraping con Python.pdf" = "09-web-scraping-datos\slides"
    "42_WebScraping.ipynb" = "09-web-scraping-datos\notebooks"

    # 10 Topicos
    "32Aprendizaje_por_refuerzo.pdf" = "10-topicos-avanzados-y-etica\slides"
    "36series_temporales.pdf" = "10-topicos-avanzados-y-etica\slides"
    "Ética en la.pdf" = "10-topicos-avanzados-y-etica\slides"
}

Write-Host "Moviendo archivos..."
foreach ($key in $moves.Keys) {
    $src = Join-Path $sourceBase $key
    $dst = Join-Path $rootDir $moves[$key]
    
    if (Test-Path $src) {
        Move-Item -Path $src -Destination $dst -Force -ErrorAction SilentlyContinue
        Write-Host "Movido: $key -> $dst" -ForegroundColor Green
    }
}

# Documento maestro
$cookbook = Join-Path $rootDir "marchine learning curso UQ\matrixcookbook.pdf"
if (Test-Path $cookbook) {
    Move-Item -Path $cookbook -Destination (Join-Path $rootDir "docs") -Force
}

Write-Host "Organización completada. Ya puedes eliminar la carpeta antigua 'marchine learning curso UQ' y subir los cambios a GitHub." -ForegroundColor Cyan
