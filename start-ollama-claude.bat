@echo off
setlocal

REM Change to the directory where this bat file lives
cd /d %~dp0

:: Push more to CPU (Reduces the stress on the Vulkan command buffer)
set OLLAMA_NUM_GPU=999


set no_proxy=localhost,127.0.0.1

REM Enable Intel GPU acceleration (Vulkan)
set OLLAMA_VULKAN=1

REM Avoid Crash on Intel GPU
set GGML_VK_DISABLE_INTEGER_DOT_PRODUCT=1

set OLLAMA_KEEP_ALIVE=-1


:: STABILITY FIXES:
:: 1. Force a small batch size so the driver doesn't time out
rem set OLLAMA_MAX_VRAM=0
rem set OLLAMA_NUM_GPU=20

:: 2. Disable Flash Attention (often unstable on Intel Vulkan)
set OLLAMA_FLASH_ATTENTION=0

:: 3. Limit parallel requests
rem set OLLAMA_NUM_PARALLEL=1

rem set OLLAMA_KV_CACHE_TYPE=f16


:: Force the model to load into the GPU on startup without a prompt
rem set OLLAMA_LOAD_TIMEOUT=5m
:: This ensures the /v1/messages endpoint is active
set OLLAMA_MODELS=C:\Users\aa\.ollama\models


:: 2. LIMIT THE WORKLOAD
:: Tells the GPU to take smaller bites of data so it doesn't 'hang' the driver.
set OLLAMA_NUM_UBATCH=128
set OLLAMA_NUM_BATCH=128
set OLLAMA_NUM_GPU=20
set OLLAMA_NUM_CTX=8192

:: 3. EXTEND TIMEOUTS
:: Prevents the 'forcibly closed' error during long thoughts.
set OLLAMA_RUN_TIMEOUT=10m





set CLAUDE_CODE_ATTRIBUTION_HEADER=0





REM Start Ollama in a new window
start "Ollama Service" cmd /k ollama.exe serve
